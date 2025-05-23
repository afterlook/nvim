-- lazy init
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- speed up loading lua modules
vim.loader.enable()
-- References to ./lua/
-- User config, mappings, etc
require('user')
-- Keymaps
require('keymaps')
-- Plugin management via Lazy
require('lazy').setup('plugins')
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

local load_core = function()
  vim.cmd([[
    hi NotifyINFOIcon guifg=#6b8e23
    hi NotifyINFOTitle guifg=#6b8e23
  ]])
end

load_core()
