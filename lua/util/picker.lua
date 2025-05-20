local M = {}

M.config = {
  matcher = {
    frecency = true,
  },
  formatters = {
    file = {
      truncate = 100,
    },
  },
}

return M
