local M = {}

function M.on_attach(client, bufnr)
  client.server_capabilities.document_formatting = false
  client.server_capabilities.documentFormattingProvider = false

  -- enable illuminate to intelligently highlight
  require('illuminate').on_attach(client)
  -- enable navic for displaying current code context
  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
  end
  local wk = require('which-key')
  wk.add({
    { '<leader>l', group = 'LSP' },
    { '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<cr>', desc = 'Go To Declaration' },
    {
      '<leader>lI',
      '<cmd>lua vim.lsp.buf.implementation()<cr>',
      desc = 'Show implementations',
    },
    { '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<cr>', desc = 'Rename' },
    { '<leader>la', '<cmd>CodeActions<cr>', desc = 'Code Action' },
    { '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>', desc = 'Go To Definition' },
    {
      '<leader>le',
      '<cmd>TroubleToggle document_diagnostics<cr>',
      desc = 'Document Diagnostics',
    },
    { '<leader>li', '<cmd>LspInfo<cr>', desc = 'Connected Language Servers' },
    { '<leader>lk', '<cmd>lua vim.lsp.buf.hover()<cr>', desc = 'Hover Commands' },
    { '<leader>ll', '<cmd>lua vim.diagnostic.open_float()<CR>', desc = 'Line Diagnostics' },
    { '<leader>ln', '<cmd>lua vim.diagnostic.goto_next()<cr>', desc = 'Next Diagnostic' },
    { '<leader>lp', '<cmd>lua vim.diagnostic.goto_prev()<cr>', desc = 'Prev Diagnostic' },
    {
      '<leader>lq',
      '<cmd>lua vim.diagnostic.setloclist()<cr>',
      desc = 'Quickfix Diagnostics',
    },
    {
      '<leader>lr',
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = 'References',
    },
    {
      '<leader>ls',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = 'Document Symbols',
    },
    { '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', desc = 'Type Definition' },
    { '<leader>lw', group = 'workspaces' },
    {
      '<leader>lwa',
      '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>',
      desc = 'Add Workspace Folder',
    },
    {
      '<leader>lwl',
      '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>',
      desc = 'List Workspace Folders',
    },
    {
      '<leader>lwr',
      '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>',
      desc = 'Remove Workspace Folder',
    },
    { '<leader>ms', '<cmd>Outline<cr>', desc = 'Toggle SymbolsOutline' },
  })
end

return M
