return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    cmdline = {
      enabled = true,
    },
    messages = {
      enabled = false,
    },
    popmenu = {
      enabled = false,
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
}
