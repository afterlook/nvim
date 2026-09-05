return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        terraform = { 'terraform_fmt' },
        tf = { 'terraform_fmt' },
        python = { 'black' },
        elixir = { 'mix' },
        rust = { 'rustfmt' },
        tex = { 'latexindent' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters = {
        stylua = {
          prepend_args = {
            '--indent-type',
            'Spaces',
            '--indent-width',
            '2',
            '--quote-style',
            'AutoPreferSingle',
            '--column-width',
            '100',
          },
        },
        latexindent = {
          prepend_args = { '-g', '/dev/null' },
        },
      },
    },
  },
}
