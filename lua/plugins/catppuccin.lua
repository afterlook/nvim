return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      vim.g.catppuccin_flavour = 'latte' -- latte, frappe, macchiato, mocha
      require('catppuccin').setup({
        integrations = {
          bufferline = true,
        },
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
