return {
  {
    'princejoogie/dir-telescope.nvim',
    -- telescope.nvim is a required dependency
    dependencies = { 'nvim-telescope/telescope.nvim' },
    opts = {
      hidden = true,
      no_ignore = false,
      show_preview = true,
    },
  },
}
