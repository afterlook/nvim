return {
  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      'telescope',
    },
    config = function()
      local fzf = require('fzf-lua')
      fzf.setup({
        'telescope',
        actions = {
          files = {
            true,
            ['alt-i'] = false,
            ['alt-h'] = false,
            ['alt-f'] = false,
            ['ctrl-i'] = { fn = fzf.actions.toggle_ignore, reuse = true, header = false },
            ['ctrl-h'] = { fn = fzf.actions.toggle_hidden, reuse = true, header = false },
            ['ctrl-f'] = { fn = fzf.actions.toggle_follow, reuse = true, header = false },
          },
          grep = {
            true,
            ['alt-i'] = false,
            ['alt-h'] = false,
            ['alt-f'] = false,
            ['ctrl-i'] = { fn = fzf.actions.toggle_ignore, reuse = true, header = false },
            ['ctrl-h'] = { fn = fzf.actions.toggle_hidden, reuse = true, header = false },
            ['ctrl-f'] = { fn = fzf.actions.toggle_follow, reuse = true, header = false },
          },
        },
      })
    end,
  },
}
