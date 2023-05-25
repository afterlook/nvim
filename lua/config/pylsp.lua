local pylsp = require("pylsp")

pylsp.setup({
  plugins = {
    rope = {
      autoimport = {
        enabled = true,
        memory = true,
      },
    },
  },
})
