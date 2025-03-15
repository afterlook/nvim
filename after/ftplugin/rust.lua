local bufnr = vim.api.nvim_get_current_buf()

local wk = require('which-key')
wk.add({
  { '<leader>c', group = 'Coding' },
  {
    '<leader>ca',
    function()
      vim.cmd.RustLsp('codeAction')
    end,
    buffer = bufnr,
    desc = 'Action',
  },
  {
    '<leader>cd',
    function()
      vim.cmd.RustLsp('openDocs')
    end,
    buffer = bufnr,
    desc = 'Docsrs',
  },
  {
    '<leader>ce',
    function()
      vim.cmd.RustLsp('explainError')
    end,
    buffer = bufnr,
    desc = 'Explain error',
  },
  { '<leader>cr', '<cmd>CargoReload<cr>', buffer = bufnr, desc = 'Cargo reload' },

  -- replaces from global lsp
  --
  -- replace hover lookup
  {
    '<leader>lk',
    function()
      vim.cmd.RustLsp({ 'hover', 'actions' })
    end,
    buffer = bufnr,
    desc = 'Hoover docs',
  },
})
