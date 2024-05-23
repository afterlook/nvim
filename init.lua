-- speed up loading lua modules
vim.loader.enable()
-- References to ./lua/
-- User config, mappings, etc
require('user')
-- Plugin management via Packer
require('plugins')
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

local load_core = function()
  vim.cmd([[
    hi NotifyINFOIcon guifg=#6b8e23
    hi NotifyINFOTitle guifg=#6b8e23
  ]])
end

load_core()
