-- Enable the following language servers
local servers = {
  'clangd',
  'lua_ls',
  'marksman',
  'tflint',
  'terraformls',
  'bashls',
  'gopls',
  'pylsp',
}

-- Prerequisite to any lsp configuration
require('mason').setup({
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
})
require('mason-lspconfig').setup({
  ensure_installed = servers,
})

require('mason-tool-installer').setup({
  ensure_installed = { 'black', 'flake8', 'isort' },
})

local M = {}

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
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
    { '<leader>lI', '<cmd>lua vim.lsp.buf.implementation()<cr>', desc = 'Show implementations' },
    { '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<cr>', desc = 'Rename' },
    { '<leader>la', '<cmd>CodeActions<cr>', desc = 'Code Action' },
    { '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>', desc = 'Go To Definition' },
    { '<leader>le', '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'Document Diagnostics' },
    { '<leader>li', '<cmd>LspInfo<cr>', desc = 'Connected Language Servers' },
    { '<leader>lk', '<cmd>lua vim.lsp.buf.hover()<cr>', desc = 'Hover Commands' },
    { '<leader>ll', '<cmd>lua vim.diagnostic.open_float()<CR>', desc = 'Line Diagnostics' },
    { '<leader>ln', '<cmd>lua vim.diagnostic.goto_next()<cr>', desc = 'Next Diagnostic' },
    { '<leader>lp', '<cmd>lua vim.diagnostic.goto_prev()<cr>', desc = 'Prev Diagnostic' },
    { '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<cr>', desc = 'Quickfix Diagnostics' },
    { '<leader>lr', '<cmd>lua vim.lsp.buf.references()<cr>', desc = 'References' },
    { '<leader>ls', '<cmd>Telescope lsp_document_symbols<cr>', desc = 'Document Symbols' },
    { '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', desc = 'Type Definition' },
    { '<leader>lw', group = 'workspaces' },
    {
      '<leader>lwa',
      '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>',
      desc = 'Add Workspace Folder',
    },
    { '<leader>lwd', '<cmd>Telescope diagnostics<cr>', desc = 'Workspace Diagnostics' },
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
    {
      '<leader>lws',
      '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>',
      desc = 'Workspace Symbols',
    },
    { '<leader>ms', '<cmd>Outline<cr>', desc = 'Toggle SymbolsOutline' },
  })

  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gr', require('telescope.builtin').lsp_references)
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap(
    '<leader>ws',
    require('telescope.builtin').lsp_dynamic_workspace_symbols,
    '[W]orkspace [S]ymbols'
  )

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(
    bufnr,
    'Format',
    vim.lsp.buf.format or vim.lsp.buf.formatting,
    { desc = 'Format current buffer with LSP' }
  )
end

vim.g.coq_settings = {
  auto_start = true,
  clients = {
    tabnine = {
      enabled = false,
    },
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('mason-lspconfig').setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require('lspconfig')[server_name].setup({
      on_attach = M.on_attach,
      capabilities = capabilities,
      diagnostics = {
        globals = { 'vim' },
      },
    })
  end,

  ['lua_ls'] = function()
    -- Make runtime files discoverable to the server
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')

    require('lspconfig').lua_ls.setup({
      on_attach = M.on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          defaultConfig = {
            quote_style = 'none',
          },
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT)
            version = 'LuaJIT',
            -- Setup your lua path
            path = runtime_path,
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = { library = vim.api.nvim_get_runtime_file('', true) },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = { enable = false },
        },
      },
    })
  end,
})

return M
