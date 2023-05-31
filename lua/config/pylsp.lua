require'lspconfig'.pylsp.setup({
  plugins = {
    rope = {
      autoimport = {
        enabled = true,
        memory = true,
      },
    },
  },
})
