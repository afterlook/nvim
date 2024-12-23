return {
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvimtools/none-ls-extras.nvim' },
    config = function()
      local nls = require('null-ls')
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

      nls.setup({
        sources = {
          nls.builtins.formatting.stylua.with({
            extra_args = {
              '--indent-type',
              'Spaces',
              '--indent-width',
              '2',
              '--quote-style',
              'AutoPreferSingle',
              '--column-width',
              '100',
            },
          }),
          -- nls.builtins.formatting.prettier.with({
          -- extra_args = { '--single-quote', 'true' },
          -- }),
          nls.builtins.formatting.terraform_fmt,
          nls.builtins.formatting.black,
          nls.builtins.diagnostics.editorconfig_checker,

          -- weird decision by mainteners to move formatters/diagnostics to different repos
          require('none-ls.diagnostics.eslint_d'),
          require('none-ls.formatting.rustfmt'),
          require('none-ls.formatting.latexindent').with({
            extra_args = { '-g', '/dev/null' }, -- https://github.com/cmhughes/latexindent.pl/releases/tag/V3.9.3
          }),
        },
        on_attach = function(client, bufnr)
          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead

                local ns = vim.api.nvim_create_namespace('my_namespace')
                -- Get a reference to the original signs handler
                local orig_signs_handler = vim.diagnostic.handlers.signs
                vim.diagnostic.handlers.signs = {
                  show = function(_, _, _, opts)
                    -- Get all diagnostics from the whole buffer rather than just the
                    -- diagnostics passed to the handler
                    local diagnostics = vim.diagnostic.get(bufnr)

                    -- Find the "worst" diagnostic per line
                    local max_severity_per_line = {}
                    for _, d in pairs(diagnostics) do
                      local m = max_severity_per_line[d.lnum]
                      if not m or d.severity < m.severity then
                        max_severity_per_line[d.lnum] = d
                      end
                    end

                    -- Pass the filtered diagnostics (with our custom namespace) to
                    -- the original handler
                    local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
                    orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
                  end,
                  hide = function(_, _)
                    orig_signs_handler.hide(ns, bufnr)
                  end,
                }

                vim.lsp.buf.format()
              end,
            })
          end
        end,
      })
    end,
  },
}
