-- [[ Sethhing options ]]
-- See `:help vim.o`

local set = vim.opt -- Tabs
local tab_width = 4
set.tabstop = tab_width
set.softtabstop = tab_width
set.shiftwidth = tab_width
set.colorcolumn = '100'

-- Relative  lines
set.relativenumber = true
-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect,noinsert'

-- Set cursorline
vim.o.cursorline = true
vim.api.nvim_create_autocmd('ColorScheme', {
  command = [[highlight CursorLine guibg=#e2e1e1 ]],
})

set.colorcolumn = '100'

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- lf plugin disable <leader>f
vim.g.lf_map_keys = 0

-- fixes nvim-tree left/right switching
vim.opt.splitright = true

-- blinking cursor
set.guicursor = 'n-v-c:blinkon100'

-- center cursor
set.scrolloff = 50

-- termguicolors
vim.opt.termguicolors = true

-- Jump to last accessed window on closing the current one
WinCloseJmp = function()
  -- Exclude floating windows
  if '' ~= vim.api.nvim_win_get_config(0).relative then
    return
  end
  -- Record the window we jump from (previous) and to (current)
  if nil == vim.t.winid_rec then
    vim.t.winid_rec = { prev = vim.fn.win_getid(), current = vim.fn.win_getid() }
  else
    vim.t.winid_rec = { prev = vim.t.winid_rec.current, current = vim.fn.win_getid() }
  end

  -- Loop through all windows to check if the previous one has been closed
  for winnr = 1, vim.fn.winnr('$') do
    if vim.fn.win_getid(winnr) == vim.t.winid_rec.prev then
      return -- Return if previous window is not closed
    end
  end

  vim.cmd([[ wincmd p ]])
end

vim.cmd([[ autocmd VimEnter,WinEnter * lua WinCloseJmp() ]])

-- disable mouse
vim.opt.mouse = 'a'

vim.g.editorconfig = true

-- overwrite tab invisible symbols and newlines
set.listchars:append({ tab = '» ', eol = '↲' })
set.list = true

vim.diagnostic.config({
  hdlr = false,
  underline = true,
  virtual_text = { spacing = 2, prefix = '' },
  signs = { '', '', '', '' }, -- set to true to use default signs, an array of 4 to specify custom signs
  update_in_insert = true,
})

-- some ai stuff
--
-- recommendation made by avante plugin maintainer
vim.opt.laststatus = 3
