local M = {}

function M.select_branch(cb)
  local output = vim.fn.systemlist('git branch --all --color=never')
  if vim.v.shell_error ~= 0 or not output or #output == 0 then
    vim.notify('No git branches found', vim.log.levels.ERROR)
    return
  end

  local branches = {}
  for _, line in ipairs(output) do
    local name = line:gsub('^%*', ''):gsub('^%s+', ''):gsub('%s+$', ''):gsub('^remotes/', '')
    if name ~= '' and not name:match('HEAD') then
      table.insert(branches, name)
    end
  end

  if #branches == 0 then
    vim.notify('No branches to select', vim.log.levels.WARN)
    return
  end

  vim.ui.select(branches, { prompt = 'Select git branch:', kind = 'git-branch' }, function(branch)
    if branch and cb then
      cb(branch)
    end
  end)
end

function M.checkout_branch()
  M.select_branch(function(branch)
    if not branch then
      return
    end
    local output = vim.fn.system({ 'git', 'checkout', branch })
    if vim.v.shell_error ~= 0 then
      vim.notify('Failed to checkout: ' .. branch .. '\n' .. output, vim.log.levels.ERROR)
    else
      vim.notify('Checked out branch: ' .. branch, vim.log.levels.INFO)
    end
  end)
end

function M.select_tag(cb)
  local output = vim.fn.systemlist('git tag')
  if vim.v.shell_error ~= 0 or not output or #output == 0 then
    vim.notify('No git tags found', vim.log.levels.ERROR)
    return
  end

  vim.ui.select(output, { prompt = 'Select git tag:', kind = 'git-tag' }, function(tag)
    if tag and cb then
      cb(tag)
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
