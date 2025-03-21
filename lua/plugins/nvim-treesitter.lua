return {
  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        -- A list of parser names, or "all" (the listed parsers MUST always be installed)
        ensure_installed = 'all',

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        -- List of parsers to ignore installing (or "all")
        ignore_install = { 'javascript' },

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            -- TODO: I'm not sure for this one.
            scope_incremental = '<c-s>',
            node_decremental = '<c-backspace>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      })
    end,
    -- opts = {
    --   -- Add languages to be installed here that you want installed for treesitter
    --   ensure_installed = { 'all' },
    --   auto_install = true,
    --
    --   highlight = {
    --     enable = true,
    --     additional_vim_regex_highlighting = false,
    --   },
    --   indent = { enable = true },
    --   incremental_selection = {
    --     enable = true,
    --     keymaps = {
    --       init_selection = '<c-space>',
    --       node_incremental = '<c-space>',
    --       -- TODO: I'm not sure for this one.
    --       scope_incremental = '<c-s>',
    --       node_decremental = '<c-backspace>',
    --     },
    --   },
    --   textobjects = {
    --     select = {
    --       enable = true,
    --       lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
    --       keymaps = {
    --         -- You can use the capture groups defined in textobjects.scm
    --         ['af'] = '@function.outer',
    --         ['if'] = '@function.inner',
    --         ['ac'] = '@class.outer',
    --         ['ic'] = '@class.inner',
    --       },
    --     },
    --     move = {
    --       enable = true,
    --       set_jumps = true, -- whether to set jumps in the jumplist
    --       goto_next_start = {
    --         [']m'] = '@function.outer',
    --         [']]'] = '@class.outer',
    --       },
    --       goto_next_end = {
    --         [']M'] = '@function.outer',
    --         [']['] = '@class.outer',
    --       },
    --       goto_previous_start = {
    --         ['[m'] = '@function.outer',
    --         ['[['] = '@class.outer',
    --       },
    --       goto_previous_end = {
    --         ['[M'] = '@function.outer',
    --         ['[]'] = '@class.outer',
    --       },
    --     },
    --     swap = {
    --       enable = true,
    --       swap_next = {
    --         ['<leader>a'] = '@parameter.inner',
    --       },
    --       swap_previous = {
    --         ['<leader>A'] = '@parameter.inner',
    --       },
    --     },
    --   },
    -- },
  },
  -- Additional textobjects for treesitter
  'nvim-treesitter/nvim-treesitter-textobjects',
}
