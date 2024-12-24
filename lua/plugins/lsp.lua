return {
  'famiu/bufdelete.nvim',
  -- Automatically install language servers to stdpath
  { 'onsails/lspkind-nvim', dependencies = { 'famiu/bufdelete.nvim' } },

  {
    'SmiteshP/nvim-navic',
    dependencies = 'neovim/nvim-lspconfig',
  },

  -- Collection of configurations for built-in LSP client
  {
    'neovim/nvim-lspconfig',
    priority = 1,
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      vim.g.coq_settings = {
        auto_start = true,
        clients = {
          tabnine = {
            enabled = false,
          },
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local on_attach = require('util/lsp').on_attach

      require('mason-lspconfig').setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require('lspconfig')[server_name].setup({
            on_attach = on_attach,
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
            on_attach = on_attach,
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
    end,
  },
}
