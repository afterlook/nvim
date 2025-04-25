vim.api.nvim_set_hl(0, 'MyAvanteCurrentGroup', {
  fg = '#ffc1c1',
  bg = '#ffd6d6',
  bold = true,
})

vim.api.nvim_set_hl(0, 'MyAvanteIncomingGroup', {
  fg = '#cefeb2',
  bg = '#daffc4',
  bold = true,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'ToggleMyPrompt',
  callback = function()
    require('avante.config').override({
      system_prompt = 'Work as normal, but provide as short descriptions as possible just to solve the problem given. Provide more details only when directly requested by me saying more, details or something similar.',
    })
  end,
})

vim.keymap.set('n', '<leader>am', function()
  vim.api.nvim_exec_autocmds('User', { pattern = 'ToggleMyPrompt' })
end, { desc = 'avante: toggle my prompt' })

return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
      -- for example
      provider = 'copilot',
      copilot = {
        model = 'claude-3.7-sonnet',
        -- model = 'o3-mini-2025-01-31',
      },
      highlights = {
        diff = {
          current = 'MyAvanteCurrentGroup',
          incoming = 'MyAvanteIncomingGroup',
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'saghen/blink.cmp', -- autocompletion for avante commands and mentions
      'saghen/blink.compat', -- more autocompletion stuff
      'ibhagwan/fzf-lua', -- for file_selector provider fzf
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- for providers='copilot'
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
}
