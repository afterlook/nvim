return {
  'famiu/bufdelete.nvim',
  -- Automatically install language servers to stdpath
  { 'onsails/lspkind-nvim', dependencies = { 'famiu/bufdelete.nvim' } },

  {
    'SmiteshP/nvim-navic',
    dependencies = 'neovim/nvim-lspconfig',
  },

  -- Collection of configurations for built-in LSP client
  {
    'neovim/nvim-lspconfig',
    priority = 1,
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      vim.g.coq_settings = {
        auto_start = true,
        clients = {
          tabnine = {
            enabled = false,
          },
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local on_attach = require('util/lsp').on_attach

      require('mason-lspconfig').setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          if server_name ~= 'rust_analyzer' then
            vim.lsp.enable('rust_analyzer')
            vim.lsp.config('rust_analyzer', {
              on_attach = on_attach,
              capabilities = capabilities,
              diagnostics = {
                globals = { 'vim' },
              },
            })
          end
        end,

        ['lua_ls'] = function()
          -- Make runtime files discoverable to the server
          local runtime_path = vim.split(package.path, ';')
          table.insert(runtime_path, 'lua/?.lua')
          table.insert(runtime_path, 'lua/?/init.lua')

          vim.lsp.enable('lua_ls')
          vim.lsp.config('lua_ls', {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
              Lua = {
                defaultConfig = {
                  quote_style = 'none',
                },
                runtime = {
                  -- Tell the language server which version of Lua you're using (most likely LuaJIT)
                  version = 'LuaJIT',
                  -- Setup your lua path
                  path = runtime_path,
                },
                diagnostics = {
                  globals = { 'vim' },
                },
                workspace = { library = vim.api.nvim_get_runtime_file('', true) },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = { enable = false },
              },
            },
          })
        end,

        ['gopls'] = function()
          vim.lsp.enable('gopls')
          vim.lsp.config('gopls', {
            on_attach = function(client, bufnr)
              local clipboardDlvBreakpointCommandCurrentLine = function()
                local currentLineNumber = vim.api.nvim_win_get_cursor(0)[1]
                local relative_filepath = vim.fn.expand('%:.')
                local breakpointString = 'break ' .. relative_filepath .. ':' .. currentLineNumber
                vim.fn.setreg('*', breakpointString)
              end

              on_attach(client, bufnr)
              require('go.lsp').gopls_on_attach(client, bufnr)
              local wk = require('which-key')
              wk.add({
                { '<leader>c', group = 'Coding' },
                { '<leader>ca', '<cmd>GoCodeAction<cr>', desc = 'Code action' },
                {
                  '<leader>cb',
                  function()
                    clipboardDlvBreakpointCommandCurrentLine()
                  end,
                  desc = 'Copy breakpoint',
                },
                { '<leader>cc', '<cmd>GoCoverage<cr>', desc = 'Test coverage' },
                { '<leader>ch', group = 'Helper' },
                { '<leader>cha', '<cmd>GoAddTag<cr>', desc = 'Add tags to struct' },
                { '<leader>chc', '<cmd>GoCoverage<cr>', desc = 'Test coverage' },
                {
                  '<leader>chg',
                  "<cmd>lua require('go.comment').gen()<cr>",
                  desc = 'Generate comment',
                },
                { '<leader>chi', '<cmd>GoModInit<cr>', desc = 'Go mod init' },
                { '<leader>chr', '<cmd>GoRMTag<cr>', desc = 'Remove tags to struct' },
                { '<leader>cht', '<cmd>GoModTidy<cr>', desc = 'Go mod tidy' },
                { '<leader>chv', '<cmd>GoVet<cr>', desc = 'Go vet' },
                { '<leader>ci', '<cmd>GoToggleInlay<cr>', desc = 'Toggle inlay' },
                { '<leader>cl', '<cmd>GoLint<cr>', desc = 'Run linter' },
                { '<leader>co', '<cmd>GoPkgOutline<cr>', desc = 'Outline' },
                { '<leader>cr', '<cmd>GoRun<cr>', desc = 'Run' },
                { '<leader>cs', '<cmd>GoFillStruct<cr>', desc = 'Autofill struct' },
                { '<leader>ct', group = 'Tests' },
                { '<leader>cta', '<cmd>GoAlt!<cr>', desc = 'Open alt file' },
                { '<leader>ctf', '<cmd>GoTestFile<cr>', desc = 'Run test for current file' },
                { '<leader>ctr', '<cmd>GoTest<cr>', desc = 'Run tests' },
                { '<leader>cts', '<cmd>GoAltS!<cr>', desc = 'Open alt file in split' },
                { '<leader>ctu', '<cmd>GoTestFunc<cr>', desc = 'Run test for current func' },
                { '<leader>ctv', '<cmd>GoAltV!<cr>', desc = 'Open alt file in vertical split' },
                { '<leader>cx', group = 'Code Lens' },
                { '<leader>cxa', '<cmd>GoCodeAction<cr>', desc = 'Code Action' },
                { '<leader>cxl', '<cmd>GoCodeLenAct<cr>', desc = 'Toggle Lens' },
              })
              wk.add({
                { '<leader>c', group = 'Coding', mode = 'v' },
                {
                  '<leader>cj',
                  "<cmd>'<,'>GoJson2Struct<cr>",
                  desc = 'Json to struct',
                  mode = 'v',
                },
              })
            end,
            capabilities = capabilities,
            settings = {
              gopls = {
                buildFlags = { '-tags=integration' },
              },
            },
          })
        end,
      })
    end,
  },
}
