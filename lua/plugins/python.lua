return {
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      'mfussenegger/nvim-dap-python', --optional
      {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
      },
    },
    lazy = false,
    branch = 'regexp', -- This is the regexp branch, use this for the new version
    opts = {},
    keys = {
      { ',v', '<cmd>VenvSelect<cr>' },
    },
  },

  {
    'python-lsp/python-lsp-server',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      local custom_attach = require('plugins/lsp').on_attach
      require('lspconfig').pylsp.setup({
        on_attach = custom_attach,
        settings = {
          pylsp = {
            plugins = {
              rope_autoimport = {
                enabled = true,
              },
              -- -- formatter options
              black = { enabled = true },
              -- -- type checker
              -- -- auto-completion options
              jedi_completion = { fuzzy = true },
              -- -- import sorting
              isort = { enabled = true },
            },
          },
        },
      })
    end,
  },
}
