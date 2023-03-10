-- References to ./lua/
-- Plugin management via Packer
require("plugins")
-- User config, mappings, etc
require("user")
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

local load_core = function()
  vim.cmd([[
    hi NotifyINFOIcon guifg=#6b8e23
    hi NotifyINFOTitle guifg=#6b8e23
  ]])
end

load_core()
