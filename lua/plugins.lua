local function get_config(name)
  return function()
    require(string.format('config/%s', name))
  end
end

require('lazy').setup({
  -- Git commands in nvim
  'tpope/vim-fugitive',

  -- Just for checkouts
  'stsewd/fzf-checkout.vim',

  -- Fugitive-companion to interact with github "tpope/vim-rhubarb"

  -- Add git related info in the signs columns and popups
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = get_config('gitsigns'),
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', config = get_config('comment') },

  -- Highlight, edit, and navigate code
  { 'nvim-treesitter/nvim-treesitter', config = get_config('treesitter') },

  -- Additional textobjects for treesitter
  'nvim-treesitter/nvim-treesitter-textobjects',

  -- LSP
  'famiu/bufdelete.nvim',
  -- Collection of configurations for built-in LSP client
  { 'neovim/nvim-lspconfig', config = get_config('lsp'), priority = 1 },
  -- Automatically install language servers to stdpath
  { 'onsails/lspkind-nvim', dependencies = { 'famiu/bufdelete.nvim' } },
  -- END LSP

  { 'rafamadriz/friendly-snippets' },

  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    config = get_config('luasnip'),
  },
  -- Theme inspired by Atom
  'mjlbach/onedark.nvim',

  -- Fancier statusline
  { 'nvim-lualine/lualine.nvim', config = get_config('lualine') },

  -- Add indentation guides even on blank lines
  { 'lukas-reineke/indent-blankline.nvim', config = get_config('indent-blankline') },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = get_config('telescope'),
    version = '0.1.6',
  },

  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- calling `setup` is optional for customization
      require('fzf-lua').setup({
        'telescope',
      })
    end,
  },

  -- Fuzzy Finder Algorithm which dependencies local dependencies to be built. Only load if `make` is available
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = vim.fn.executable('make') == 1,
  },

  { 'windwp/nvim-autopairs', config = get_config('nvim-autopairs') },

  {
    'folke/which-key.nvim',
    dependencies = { 'echasnovski/mini.icons' },
    config = get_config('which-key'),
  },

  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvimtools/none-ls-extras.nvim' },
    config = get_config('null-ls'),
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = get_config('nvim-tree'),
    branch = 'master',
  },

  { 'glepnir/dashboard-nvim', config = get_config('dashboard') },

  {
    'folke/trouble.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('trouble').setup({
        -- your configuration comes here
        -- or leave it empty to the default settings
        -- refer to the configuration section below
      })
    end,
  },

  {
    'SmiteshP/nvim-navic',
    dependencies = 'neovim/nvim-lspconfig',
  },

  { 'RRethy/vim-illuminate' },

  {
    'hedyhli/outline.nvim',
    config = get_config('symbols'),
  },

  { 'Djancyp/cheat-sheet' },

  {
    'numToStr/Navigator.nvim',
    config = get_config('navigator'),
  },

  {
    'romgrk/barbar.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = get_config('barbar'),
  },

  {
    'ojroques/nvim-lspfuzzy',
    dependencies = {
      { 'junegunn/fzf' },
      { 'junegunn/fzf.vim' }, -- to enable preview (optional)
    },
    config = function()
      require('lspfuzzy').setup({})
    end,
  },

  {
    'ray-x/go.nvim',
    dependencies = {
      { 'ray-x/guihua.lua' },
      { 'theHamsta/nvim-dap-virtual-text' },
      { 'mfussenegger/nvim-dap' },
      { 'rcarriga/nvim-dap-ui' },
    },
    event = { 'CmdlineEnter' },
    config = get_config('go'),
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()',
  },

  {
    'gfanto/fzf-lsp.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
  },

  { 'f-person/git-blame.nvim', config = get_config('git-blame') },

  {
    'kosayoda/nvim-lightbulb',
    dependencies = 'antoinemadec/FixCursorHold.nvim',
    config = get_config('lightbulb'),
  },

  { 'catppuccin/nvim', name = 'catppuccin', config = get_config('catppuccin') },

  { 'akinsho/toggleterm.nvim', version = '*', config = get_config('toggleterm') },

  { 'haskell/haskell-language-server' },

  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
  },

  {
    'ThePrimeagen/harpoon',
    config = get_config('harpoon'),
  },

  {
    'folke/noice.nvim',
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
    },
    config = get_config('noice'),
  },

  {
    'christoomey/vim-tmux-navigator',
  },

  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = get_config('refactoring'),
  },

  {
    'iamcco/markdown-preview.nvim',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },

  {
    'princejoogie/dir-telescope.nvim',
    -- telescope.nvim is a required dependency
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('dir-telescope').setup({
        -- these are the default options set
        hidden = true,
        no_ignore = false,
        show_preview = true,
      })
    end,
  },

  -- rust
  {
    'simrat39/rust-tools.nvim',
    config = get_config('rust-tools'),
  },
  -- end rust

  -- python
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      'mfussenegger/nvim-dap-python', --optional
      {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
      },
    },
    lazy = false,
    branch = 'regexp', -- This is the regexp branch, use this for the new version
    config = function()
      require('venv-selector').setup()
    end,
    keys = {
      { ',v', '<cmd>VenvSelect<cr>' },
    },
  },

  {
    'python-lsp/python-lsp-server',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = get_config('pylsp'),
  },
  -- end python

  {
    'smoka7/hop.nvim',
    branch = 'master',
    config = get_config('hop'),
  },

  { 'kevinhwang91/nvim-bqf', ft = 'qf' },

  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = '*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        ['<Tab>'] = { 'select_next', 'fallback' }, -- snippets
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        -- ['<CR>'] = { 'accept', 'fallback' },
        ['<CR>'] = { 'select_and_accept', 'fallback' },
        ['<C-l>'] = { 'show', 'hide', 'fallback' },
        ['<C-_>'] = { 'cancel', 'fallback' },
        ['<C-Space>'] = { 'show_documentation', 'hide_documentation', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-j>'] = { 'snippet_forward', 'fallback' },
        ['<C-k>'] = { 'snippet_backward', 'fallback' },
      },

      completion = {
        list = { selection = 'preselect' },
        accept = { auto_brackets = { enabled = true } },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
        },
        menu = {
          draw = { columns = { { 'label', 'label_description', gap = 1 }, { 'kind' } } },
        },
      },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
    opts_extend = { 'sources.default' },

    snippets = {
      expand = function(snippet)
        require('luasnip').lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require('luasnip').jumpable(filter.direction)
        end
        return require('luasnip').in_snippet()
      end,
      jump = function(direction)
        require('luasnip').jump(direction)
      end,
    },
    sources = {
      default = { 'lsp', 'path', 'luasnip', 'buffer' },
    },
  },
})
