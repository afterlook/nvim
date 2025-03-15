return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
      'Kaiser-Yang/blink-cmp-avante',
      'rafamadriz/friendly-snippets',
      { 'folke/lazydev.nvim', ft = 'lua' },
    },

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
        ['C-y'] = { 'select_and_accept', 'fallback' },
        ['<C-l>'] = { 'show', 'hide', 'fallback' },
        ['<C-_>'] = { 'cancel', 'fallback' },
        ['<C-Space>'] = { 'show_documentation', 'hide_documentation', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-j>'] = { 'snippet_forward', 'fallback' },
        ['<C-k>'] = { 'snippet_backward', 'fallback' },
      },

      completion = {
        list = {
          selection = { preselect = true, auto_insert = true },
        },
        accept = { auto_brackets = { enabled = true } },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
        },
        menu = {
          draw = {
            columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
          },
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
        default = { 'lsp', 'snippets', 'lazydev', 'path', 'buffer' },
        providers = {
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
            opts = {
              -- options for blink-cmp-avante
            },
          },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
          },
          snippets = {
            name = 'Luasnip',
            module = 'blink.cmp.sources.snippets',
          },
        },
      },
    },
    opts_extend = { 'sources.default' },

    snippets = { preset = 'luasnip' },
    -- ensure you have the `snippets` source (enabled by default)
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
}
