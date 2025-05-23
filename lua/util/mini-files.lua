local M = {}

function M.open_current_file()
  local mf = require('mini.files')
  mf.open(vim.api.nvim_buf_get_name(0))
end

return M
