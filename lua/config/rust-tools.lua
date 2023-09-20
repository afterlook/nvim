local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(client, bufnr)
      require("config/lsp").on_attach(client, bufnr)
      local wk = require("which-key")
      local default_options = { silent = true }
      wk.register({
        c = {
          name = "Coding",
          h = { "<cmd>lua require('rust-tools').hover_actions.hover_actions()<cr>", "Hoover docs", buffer = bufnr },
          a = {
            "<cmd>lua require('rust-tools').code_action_group.code_action_group()<cr>",
            "Action",
            buffer = bufnr,
          },
          r = { "<cmd>CargoReload<cr>", "Cargo reload", buffer = bufnr },
        },
      }, { prefix = "<leader>", mode = "n", default_options })
    end,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
})

require("rust-tools").inlay_hints.enable()
