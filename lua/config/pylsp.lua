local custom_attach = require('config/lsp').on_attach

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
