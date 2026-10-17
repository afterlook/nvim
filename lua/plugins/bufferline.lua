return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup({
        options = {
          always_show_bufferline = true,
          separator_style = 'slant',
          diagnostics = 'nvim_lsp',
          show_buffer_close_icons = false,
          show_close_icon = false,
        },
      })
    end,
  },
}
