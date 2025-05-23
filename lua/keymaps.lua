-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<C-n>', ':cprev<CR>', { silent = true })
vim.keymap.set('n', '<C-m>', ':cnext<CR>', { silent = true })
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- Switching panes
--vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", { silent = true })
--vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", { silent = true })
--vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", { silent = true })
--vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", { silent = true })

-- gotodefs
vim.api.nvim_set_keymap(
  'n',
  'gD',
  '<cmd>lua vim.lsp.buf.declaration()<CR>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  'n',
  'gd',
  '<cmd>lua vim.lsp.buf.definition()<CR>',
  { noremap = true, silent = true }
)

vim.keymap.set('n', '<c-q>', ':bd<CR>', { silent = true })

local function yankFileToClipboard()
  local filepath = vim.fn.expand('%')
  vim.fn.setreg('*', filepath) -- write to clippoard
  print('Copied to clipboard ' .. filepath)
end
vim.keymap.set('n', 'gy', yankFileToClipboard, { noremap = true, silent = false })
