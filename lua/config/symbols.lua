require("outline").setup({
  guides = {
    enabled = true
  },
  keymaps = {
    close = { "<Esc>", "q" },
    code_actions = "a",
    fold = "h",
    fold_all = "W",
    fold_reset = "R",
    goto_location = "<Cr>",
    hover_symbol = "<C-space>",
    peek_location = "o",
    rename_symbol = "r",
    toggle_preview = "K",
    unfold = "l",
    unfold_all = "E"
  },
  outline_items = {
    highlight_hovered_item = true,
    show_symbol_details = true
  },
  outline_window = {
    auto_close = false,
    position = "right",
    relative_width = true,
    show_numbers = false,
    show_relative_numbers = false,
    width = 25
  },
  preview_window = {
    auto_preview = false,
    winhl = "Normal:Pmenu"
  },
  provider = {
    lsp = {
      blacklist_clients = {}
    }
  },
  symbol_folding = {
    auto_unfold_hover = true,
    markers = { "", "" }
  },
  symbols = {
    filter = {
      exclude = true
    }
  }
})
