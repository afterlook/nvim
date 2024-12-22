return {
  -- Add indentation guides even on blank lines
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('ibl').setup({
        indent = { char = '┊' },
        whitespace = {
          remove_blankline_trail = true,
        },
        scope = {
          enabled = false,
        },
      })
    end,
  },
}
