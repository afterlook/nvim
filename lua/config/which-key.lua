local wk = require('which-key')
local gs = require('gitsigns')
local default_options = { silent = true }

local function createGitBranch()
  local branchName = vim.fn.input('New branch name: ')
  vim.cmd('G checkout -b' .. branchName)
end

-- Register all leader based mappings
wk.register({
  ['<Tab>'] = { '<cmd>e#<cr>', 'Prev buffer' },
  ['<leader>'] = { name = 'Leader', a = { "<cmd>lua print('fasfAS')<cr>", 'test' } },
  f = {
    name = 'Files',
    b = { '<cmd>Telescope file_browser<cr>', 'File browser' },
    g = { '<cmd>NvimTreeFindFile<cr>', 'Find in tree' },
    f = { '<cmd>Telescope find_files<cr>', 'Find File' },
    p = { '<cmd>NvimTreeToggle<cr>', 'Toggle Filetree' },
    r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
    a = { '<cmd>wa<cr>', 'Save all Buffers' },
    s = { '<cmd>w<cr>', 'Save Buffer' },
    z = { '<cmd>Telescope zoxide list<CR>', 'Zoxide' },
  },
  m = {
    name = 'Misc',
    c = { '<cmd>CheatSH<cr>', 'Cht.sh' },
    p = { '<cmd>PackerSync<cr>', 'PackerSync' },
    t = { '<cmd>ToggleTerm<cr>', 'Terminal' },
    h = { '<cmd>Noice telescope<cr>', 'Messages history' },
    m = {
      name = 'Markdown',
      m = { '<cmd>MarkdownPreview<cr>', 'Preview' },
      s = { '<cmd>MarkdownPreviewStop<cr>', 'Preview stop' },
    },
  },
  s = {
    name = 'Search',
    f = { '<cmd>Telescope find_files<cr>', 'Search Files' },
    h = { '<cmd>Telescope help_tags<cr>', 'Search Help' },
    w = { '<cmd>Telescope grep_string<cr>', 'Search current Word' },
    g = { '<cmd>Telescope live_grep<cr>', 'Search by Grep' },
    -- G = {
    --   '<cmd>lua require("telescope.builtin").live_grep({ additional_args = function() return { "--max-depth=1", } end })<cr>',
    --   'Search by Grep',
    -- },
    d = { '<cmd>Telescope dir live_grep<cr>', 'Search in Directory' },
    q = { '<cmd>Telescope diagnostics<cr>', 'Search Diagnostics' },
  },
  g = {
    name = 'Git',
    a = { '<cmd>G add .<cr>', 'Add all' },
    s = { '<cmd>G status<cr>', 'Status' },
    c = { '<cmd>G commit --signoff<cr>', 'Commit buffer' },
    P = { '<cmd>G push<cr>', 'Push' },
    p = { '<cmd>G pull<cr>', 'Pull' },
    l = { '<cmd>G log<cr>', 'Log' },
    b = { '<cmd>GBranches<cr>', 'Branch switch' },
    n = { createGitBranch, 'New branch' },
    S = { gs.stage_buffer, 'Stage buffer' },
    u = { gs.undo_stage_hunk, 'Undo stage hunk' },
    r = {
      name = 'Reset',
      R = { gs.reset_buffer, 'Reset buffer' },
    },
    BB = {
      function()
        gs.blame_line({ full = true })
      end,
      'Blame full',
    },
    B = { '<cmd>:GitBlameToggle<cr>', 'Blame line' },
    D = { gs.diffthis, 'Diff' },
    d = { gs.toggle_deleted, 'Show deleted' },
  },
  q = {
    name = 'Quit',
    q = { '<cmd>xa<cr>', 'Safe Quit' },
    s = { '<cmd>qa<cr>', 'Quit with Buffer Check' },
    z = { '<cmd>qa<cr>', 'Force quit' },
  },
  h = {
    name = 'Harpoon',
    a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", 'Add file' },
    q = { "<cmd>lua require('harpoon.mark').nav_prev()<cr>", 'Prev' },
    e = { "<cmd>lua require('harpoon.mark').nav_next()<cr>", 'Next' },
    l = { '<cmd>Telescope harpoon marks<cr>', 'Show marks' },
    r = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", 'Edit' },
    ['1'] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", 'File 1' },
    ['2'] = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", 'File 2' },
    ['3'] = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", 'File 3' },
    ['4'] = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", 'File 4' },
  },
}, { prefix = '<leader>', mode = 'n', default_options })

wk.register({
  r = {
    name = 'Refactor',
    e = {
      function()
        require('refactoring').refactor('Extract Function')
      end,
      'Extract function',
    },
  },
}, { prefix = '<leader>', mode = 'v', default_options })
