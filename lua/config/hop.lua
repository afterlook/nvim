local hop = require('hop')
hop.setup({ keys = 'etovxqpdygfblzhckisuran' })

local opts = { noremap = true, silent = true }
local directions = require('hop.hint').HintDirection

vim.keymap.set('', 'f', function()
  hop.hint_patterns({ current_line_only = false })
end, opts)
vim.keymap.set('', 'F', function()
  hop.hint_patterns({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, opts)
