return {
  {
    'folke/which-key.nvim',
    dependencies = { 'echasnovski/mini.icons' },
    config = function()
      local wk = require('which-key')
      local gs = require('gitsigns')

      local function createGitBranch()
        local branchName = vim.fn.input('New branch name: ')
        vim.cmd('G checkout -b' .. branchName)
      end

      -- Register all leader based mappings
      wk.add({
        { '<leader><Tab>', '<cmd>e#<cr>', desc = 'Prev buffer' },
        { '<leader><leader>', group = 'Leader' },
        { '<leader><leader>a', "<cmd>lua print('fasfAS')<cr>", desc = 'test' },

        { '<leader>f', group = 'Files' },
        { '<leader>fa', '<cmd>wa<cr>', desc = 'Save all Buffers' },
        { '<leader>ff', '<cmd>FzfLua files<cr>', desc = 'Find File' },
        { '<leader>fg', '<cmd>NvimTreeFindFile<cr>', desc = 'Find in tree' },
        { '<leader>fp', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle Filetree' },
        { '<leader>fr', '<cmd>FzfLua oldfiles<cr>', desc = 'Open Recent File' },
        { '<leader>fs', '<cmd>w<cr>', desc = 'Save Buffer' },

        { '<leader>g', group = 'Git' },
        { '<leader>gB', '<cmd>:GitBlameToggle<cr>', desc = 'Blame line' },
        {
          '<leader>gBB',
          function()
            gs.blame_line({ full = true })
          end,
          desc = 'Blame full',
        },
        { '<leader>gD', gs.diffthis, desc = 'Diff' },
        { '<leader>gP', '<cmd>G push<cr>', desc = 'Push' },
        { '<leader>gS', gs.stage_buffer, desc = 'Stage buffer' },
        { '<leader>ga', '<cmd>G add .<cr>', desc = 'Add all' },
        { '<leader>gb', '<cmd>GBranches<cr>', desc = 'Branch switch' },
        { '<leader>gc', '<cmd>G commit --signoff<cr>', desc = 'Commit buffer' },
        { '<leader>gd', gs.toggle_deleted, desc = 'Show deleted' },
        { '<leader>gl', '<cmd>G log<cr>', desc = 'Log' },
        { '<leader>gn', createGitBranch, desc = 'New branch' },
        { '<leader>gp', '<cmd>G pull<cr>', desc = 'Pull' },
        { '<leader>gr', group = 'Reset' },
        { '<leader>grR', gs.reset_buffer, desc = 'Reset buffer' },
        { '<leader>gs', '<cmd>G status<cr>', desc = 'Status' },
        { '<leader>gu', gs.undo_stage_hunk, desc = 'Undo stage hunk' },

        { '<leader>h', group = 'Harpoon' },
        { '<leader>h1', "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = 'File 1' },
        { '<leader>h2', "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = 'File 2' },
        { '<leader>h3', "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = 'File 3' },
        { '<leader>h4', "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = 'File 4' },
        { '<leader>ha', "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = 'Add file' },
        { '<leader>he', "<cmd>lua require('harpoon.mark').nav_next()<cr>", desc = 'Next' },
        { '<leader>hl', '<cmd>Telescope harpoon marks<cr>', desc = 'Show marks' },
        { '<leader>hq', "<cmd>lua require('harpoon.mark').nav_prev()<cr>", desc = 'Prev' },
        { '<leader>hr', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = 'Edit' },

        { '<leader>m', group = 'Misc' },
        { '<leader>mc', '<cmd>CheatSH<cr>', desc = 'Cht.sh' },
        { '<leader>mh', '<cmd>Noice telescope<cr>', desc = 'Messages history' },
        { '<leader>mm', group = 'Markdown' },
        { '<leader>mmm', '<cmd>MarkdownPreview<cr>', desc = 'Preview' },
        { '<leader>mms', '<cmd>MarkdownPreviewStop<cr>', desc = 'Preview stop' },
        { '<leader>mp', '<cmd>PackerSync<cr>', desc = 'PackerSync' },
        { '<leader>mt', '<cmd>ToggleTerm<cr>', desc = 'Terminal' },

        { '<leader>q', group = 'Quit' },
        { '<leader>qq', '<cmd>xa<cr>', desc = 'Safe Quit' },
        { '<leader>qs', '<cmd>qa<cr>', desc = 'Quit with Buffer Check' },
        { '<leader>qz', '<cmd>qa<cr>', desc = 'Force quit' },

        { '<leader>s', group = 'Search' },
        { '<leader>sf', '<cmd>FzfLua files<cr>', desc = 'Search Files' },
        { '<leader>sg', '<cmd>FzfLua live_grep_glob<cr>', desc = 'Search by Grep' },
        { '<leader>sh', '<cmd>FzfLua helptags<cr>', desc = 'Search Help' },
        { '<leader>sq', '<cmd>FzfLua diagnostics_workspace<cr>', desc = 'Search Diagnostics' },
        { '<leader>ss', '<cmd>FzfLua lsp_document_symbols<cr>', desc = 'Search Symbols' },
        { '<leader>sw', '<cmd>FzfLua grep_cword<cr>', desc = 'Search current Word' },
      })

      wk.add({
        { '<leader>r', group = 'Refactor', mode = 'v' },
        {
          '<leader>re',
          function()
            require('refactoring').refactor('Extract Function')
          end,
          desc = 'Extract function',
          mode = 'v',
        },
      })
    end,
  },
}
