local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

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
  { 'neovim/nvim-lspconfig', config = get_config('lsp') },
  -- Automatically install language servers to stdpath
  { 'onsails/lspkind-nvim', dependencies = { 'famiu/bufdelete.nvim' } },
  -- END LSP

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'f3fora/cmp-spell',
      'hrsh7th/cmp-calc',
      'lukas-reineke/cmp-rg',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
    },
    config = get_config('cmp'),
  },

  { 'rafamadriz/friendly-snippets' },

  {
    'L3MON4D3/LuaSnip',
    dependencies = 'saadparwaiz1/cmp_luasnip',
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

  { 'folke/which-key.nvim', config = get_config('which-key') },

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
    dependencies = 'williamboman/mason-lspconfig.nvim',
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
    'python-lsp/python-lsp-server',
    config = get_config('pylsp'),
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

  {
    'smoka7/hop.nvim',
    branch = 'master',
    config = get_config('hop'),
  },

  { 'kevinhwang91/nvim-bqf', ft = 'qf' },
})
