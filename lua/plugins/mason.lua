return {
  {
    'mason-org/mason.nvim',
    version = '^1.0.0',
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
  {
    'mason-org/mason-lspconfig.nvim',
    version = '^1.0.0',
    opts = {
      ensure_installed = {
        'clangd',
        'lua_ls',
        'marksman',
        'tflint',
        'terraformls',
        'bashls',
        'gopls',
        'pylsp',
        'jdtls',
      },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = { 'black', 'flake8', 'isort' },
    },
  },
}
