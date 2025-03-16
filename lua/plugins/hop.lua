return {
  {
    'smoka7/hop.nvim',
    branch = 'master',
    opts = {
      keys = 'etovxqpdygfblzhckisuran',
    },
    config = function()
      local hop = require('hop')
      hop.setup({})

      local opts = { noremap = true, silent = true }
      local directions = require('hop.hint').HintDirection

      vim.keymap.set('', '9f', function()
        hop.hint_patterns({ current_line_only = false })
      end, opts)
      vim.keymap.set('', '9F', function()
        hop.hint_patterns({ direction = directions.AFTER_CURSOR, current_line_only = false })
      end, opts)
    end,
  },
}
