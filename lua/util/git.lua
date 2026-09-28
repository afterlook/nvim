local M = {}

-- Branch picker cache
local _branch_cache = nil ---@type {items: table[], cwd: string, time: number}?
local BRANCH_CACHE_TTL = 30 -- seconds; set to 0 to disable
local _fetching = false
local _fetching_cwd = nil
local _refreshing_branch_cache_cwd = nil

local function _parse_branches_for_each_ref(stdout, cwd)
  local items = {}
  for _, line in ipairs(vim.split(stdout, '\n', { trimempty = true })) do
    local ref, branch, head_marker, commit, msg =
      line:match('([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t(.*)')
    local is_remote = ref and ref:match('^refs/remotes/')
    local is_remote_head = is_remote and ref:match('/HEAD$')
    if branch and branch ~= '' and not is_remote_head then
      table.insert(items, {
        text = branch, -- used by the fuzzy matcher
        branch = branch,
        current = head_marker == '*',
        commit = commit,
        msg = msg,
        cwd = cwd,
        remote = is_remote,
      })
    end
  end
  return items
end

local function _refresh_branch_cache(cwd, callback)
  vim.system(
    {
      'git',
      'for-each-ref',
      '--sort=-committerdate',
      '--format=%(refname)\t%(refname:short)\t%(HEAD)\t%(objectname:short)\t%(contents:subject)',
      'refs/heads/',
      'refs/remotes/',
    },
    { text = true, cwd = cwd },
    vim.schedule_wrap(function(result)
      if result.code ~= 0 or not result.stdout or result.stdout == '' then
        callback(nil, result)
        return
      end

      local items = _parse_branches_for_each_ref(result.stdout, cwd)
      _branch_cache = { items = items, cwd = cwd, time = os.time() }
      callback(items, result)
    end)
  )
end

local function _checkout_remote_branch(picker, item)
  _branch_cache = nil
  picker:close()

  vim.system({ 'git', 'checkout', '--track', item.branch }, { text = true, cwd = item.cwd }, function(result)
    vim.schedule(function()
      if result.code ~= 0 then
        vim.notify('Failed to checkout ' .. item.branch .. '\n' .. (result.stderr or ''), vim.log.levels.ERROR)
        return
      end

      vim.notify('Checked out ' .. item.branch, vim.log.levels.INFO)
    end)
  end)
end

local function _open_branch_picker(items)
  Snacks.picker.pick({
    title = 'Git Branches',
    items = items,
    format = 'git_branch',
    preview = false,
    confirm = function(picker, item)
      _branch_cache = nil -- invalidate so next open reflects new HEAD
      if item.remote then
        _checkout_remote_branch(picker, item)
        return
      end
      require('snacks.picker.actions').git_checkout(picker, item)
    end,
    win = {
      input = {
        keys = {
          ['<c-a>'] = { 'git_branch_add', mode = { 'n', 'i' } },
          ['<c-x>'] = { 'git_branch_del', mode = { 'n', 'i' } },
        },
      },
    },
    on_show = function(picker)
      for i, item in ipairs(picker:items()) do
        if item.current then
          picker.list:view(i)
          Snacks.picker.actions.list_scroll_center(picker)
          break
        end
      end
    end,
  })
end

-- Helper: Get current tag if on a tag
local function get_current_tag()
  local tag_output = vim.fn.system('git describe --tags --exact-match HEAD 2>/dev/null')
  if vim.v.shell_error == 0 then
    return tag_output:gsub('%s+$', '')
  end
  return nil
end

-- Helper: Mark item as current and move to top of list (used by tags)
local function mark_and_move_current(items, item_map, current_value)
  local current_idx = nil

  -- Find and mark in single pass
  for i, item in ipairs(items) do
    if (item_map[item] or item) == current_value then
      local marked = item .. ' ★'
      item_map[marked] = item_map[item] or item
      item_map[item] = nil
      items[i] = marked
      current_idx = i
      break
    end
  end

  -- Move to top if found
  if current_idx and current_idx > 1 then
    local marked = items[current_idx]
    table.remove(items, current_idx)
    table.insert(items, 1, marked)
  end
end

-- Helper: Parse git branches into local and remote lists
local function parse_branches(output)
  local local_branches = {}
  local remote_branches = {}
  local branch_map = {}
  local current_branch_display = nil

  for _, line in ipairs(output) do
    local is_current = line:sub(1, 1) == '*'
    local name = line:gsub('^%*', ''):gsub('^%s+', ''):gsub('%s+$', '')

    if name ~= '' and not name:match('HEAD') then
      if name:sub(1, 7) == 'remotes/' then
        local remote_name = name:sub(9) -- remove 'remotes/'
        table.insert(remote_branches, remote_name)
        branch_map[remote_name] = name
      else
        if is_current then
          current_branch_display = name .. ' ★'
          branch_map[current_branch_display] = name
        else
          table.insert(local_branches, name)
          branch_map[name] = name
        end
      end
    end
  end

  -- Insert current branch at the beginning
  if current_branch_display then
    table.insert(local_branches, 1, current_branch_display)
  end

  return local_branches, remote_branches, branch_map
end

function M.select_branch(cb)
  vim.system(
    { 'git', 'branch', '--all', '--color=never' },
    { text = true },
    vim.schedule_wrap(function(result)
      if result.code ~= 0 or not result.stdout or result.stdout == '' then
        vim.notify('No git branches found', vim.log.levels.ERROR)
        return
      end

      local output = vim.split(result.stdout, '\n', { trimempty = true })
      local local_branches, remote_branches, branch_map = parse_branches(output)

      if #local_branches == 0 and #remote_branches == 0 then
        vim.notify('No branches to select', vim.log.levels.WARN)
        return
      end

      -- Build combined list
      local branches = {}
      vim.list_extend(branches, local_branches)
      if #local_branches > 0 and #remote_branches > 0 then
        table.insert(branches, '--- Remotes ---')
      end
      vim.list_extend(branches, remote_branches)

      vim.ui.select(branches, { prompt = 'Select git branch:', kind = 'git-branch' }, function(branch)
        if branch and branch ~= '--- Remotes ---' and cb then
          local canonical_name = branch_map[branch] or branch:gsub(' ★$', '')
          cb(canonical_name)
        end
      end)
    end)
  )
end

function M.checkout_branch()
  local cwd = vim.fn.getcwd()
  local now = os.time()

  -- A fetch retains the last completed cache so the picker can open immediately.
  if _branch_cache
    and _branch_cache.cwd == cwd
    and (
      (now - _branch_cache.time) < BRANCH_CACHE_TTL
      or _fetching_cwd == cwd
      or _refreshing_branch_cache_cwd == cwd
    )
  then
    _open_branch_picker(_branch_cache.items)
    return
  end

  -- Do not make the picker wait for, or duplicate, work started by <leader>gf.
  if _fetching_cwd == cwd or _refreshing_branch_cache_cwd == cwd then
    vim.notify('Branch list is refreshing; try again momentarily', vim.log.levels.INFO)
    return
  end

  _refresh_branch_cache(cwd, function(items)
    if not items then
      -- Fallback to default snacks picker on error.
      Snacks.picker.git_branches({ preview = false })
      return
    end
    _open_branch_picker(items)
  end)
end

function M.fetch()
  if _fetching then
    vim.notify('Fetch already in progress', vim.log.levels.INFO)
    return
  end

  local cwd = vim.fn.getcwd()
  _fetching = true
  _fetching_cwd = cwd
  vim.system({ 'git', 'fetch' }, { text = true, cwd = cwd }, vim.schedule_wrap(function(result)
    _fetching = false
    _fetching_cwd = nil
    if result.code ~= 0 then
      vim.notify('Failed to fetch remote branches\n' .. (result.stderr or ''), vim.log.levels.ERROR)
      return
    end

    _refreshing_branch_cache_cwd = cwd
    _refresh_branch_cache(cwd, function(items)
      _refreshing_branch_cache_cwd = nil
      if not items then
        vim.notify('Fetched remote branches, but failed to refresh branch picker', vim.log.levels.WARN)
        return
      end

      vim.notify('Fetched remote branches', vim.log.levels.INFO)
    end)
  end))
end

function M.select_tag(cb)
  local output = vim.fn.systemlist('git tag')
  if vim.v.shell_error ~= 0 or not output or #output == 0 then
    vim.notify('No git tags found', vim.log.levels.ERROR)
    return
  end

  local current_tag = get_current_tag()
  local tags = {}
  local tag_map = {}

  for _, tag in ipairs(output) do
    table.insert(tags, tag)
    tag_map[tag] = tag
  end

  if current_tag then
    mark_and_move_current(tags, tag_map, current_tag)
  end

  vim.ui.select(tags, { prompt = 'Select git tag:', kind = 'git-tag' }, function(tag)
    if tag and cb then
      local canonical_name = tag_map[tag] or tag:gsub(' ★$', '')
      cb(canonical_name)
    end
  end)
end

function M.checkout_tag()
  M.select_tag(function(tag)
    if not tag then
      return
    end
    local output = vim.fn.system({ 'git', 'checkout', tag })
    if vim.v.shell_error ~= 0 then
      vim.notify('Failed to checkout: ' .. tag .. '\n' .. output, vim.log.levels.ERROR)
    else
      vim.notify('Checked out tag: ' .. tag, vim.log.levels.INFO)
    end
  end)
end

return M
