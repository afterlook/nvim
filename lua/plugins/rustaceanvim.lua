return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    config = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {},
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            require('util/lsp').on_attach(client, bufnr)
            -- you can also put keymaps in here
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
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {},
          },
        },
        -- DAP configuration
        dap = {},
      }
    end,
    dependencies = {
      'neovim/nvim-lspconfig',
    },
  },
}
