return {
  'echasnovski/mini.nvim',
  version = false,
  dependencies = { 'SmiteshP/nvim-navic' },
  config = function()
    require('mini.pairs').setup()
    require('mini.surround').setup()
    require('mini.files').setup()
    require('mini.statusline').setup({
      content = {
        active = function()
          local statusline = require('mini.statusline')
          local navic = require('nvim-navic')
          local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
          local git = statusline.section_git({ trunc_width = 40 })
          local diff = statusline.section_diff({ trunc_width = 75 })
          local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
          local lsp = statusline.section_lsp({ trunc_width = 75 })
          local filename = statusline.section_filename({ trunc_width = 140 })
          local breadcrumbs = not statusline.is_truncated(120) and navic.is_available()
              and navic.get_location() or ''
          local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
          local location = statusline.section_location({ trunc_width = 75 })
          local search = statusline.section_searchcount({ trunc_width = 75 })

          return statusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
            '%<',
            { hl = 'MiniStatuslineFilename', strings = { filename, breadcrumbs } },
            '%=',
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            { hl = mode_hl, strings = { search, location } },
          })
        end,
      },
    })
    require('mini.ai').setup()
  end,
}
