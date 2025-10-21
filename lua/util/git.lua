local M = {}

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
  local output = vim.fn.systemlist('git branch --all --color=never')
  if vim.v.shell_error ~= 0 or not output or #output == 0 then
    vim.notify('No git branches found', vim.log.levels.ERROR)
    return
  end

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
end

function M.checkout_branch()
  M.select_branch(function(branch)
    if not branch then
      return
    end
    local remote, local_name = branch:match('([^/]+)/(.+)')
    local checkout_target = (remote and local_name) and local_name or branch

    local output = vim.fn.system({ 'git', 'checkout', checkout_target })
    if vim.v.shell_error ~= 0 then
      vim.notify('Failed to checkout: ' .. checkout_target .. '\n' .. output, vim.log.levels.ERROR)
    else
      vim.notify('Checked out branch: ' .. checkout_target, vim.log.levels.INFO)
    end
  end)
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
