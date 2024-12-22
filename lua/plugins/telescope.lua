return {
  {
    'nvim-telescope/telescope.nvim',
    version = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },

    opts = {
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
        file_ignore_patterns = {
          'vendor',
        },
      },
    },

    config = function()
      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')
      -- See `:help telescope.builtin`
      vim.keymap.set(
        'n',
        '<leader>?',
        require('telescope.builtin').oldfiles,
        { desc = '[?] Find recently opened files' }
      )
      vim.keymap.set(
        'n',
        '<leader><space>',
        require('telescope.builtin').buffers,
        { desc = '[ ] Find existing buffers' }
      )
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(
          require('telescope.themes').get_dropdown({
            winblend = 10,
            previewer = false,
          })
        )
      end, { desc = '[/] Fuzzily search in current buffer]' })
    end,
  },

  -- Fuzzy Finder Algorithm which dependencies local dependencies to be built. Only load if `make` is available
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = vim.fn.executable('make') == 1,
  },
}
