-- Git integration and tools
return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- Git integration
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    opts = {},
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'DiffView' },
    },
  },

  { -- Magit-like Git interface for Neovim
    -- Neogit provides a powerful Git interface similar to Emacs Magit
    -- Offers staging, committing, branching, and other Git operations in a clean UI
    'NeogitOrg/neogit',

    dependencies = {
      'nvim-lua/plenary.nvim',         -- required
      'sindrets/diffview.nvim',        -- optional - Diff integration
      'nvim-telescope/telescope.nvim', -- optional - for enhanced picking
    },

    -- Load when Git command is triggered
    cmd = 'Neogit',

    -- Keymap as requested
    keys = {
      { '<C-x>g', '<cmd>Neogit<cr>', desc = 'Open Neogit' },
    },

    -- Configuration options
    opts = {
      -- Disable signs in the buffer
      disable_signs = false,

      -- Disable line highlighting
      disable_hint = false,

      -- Disable context highlighting
      disable_context_highlighting = false,

      -- Disable commit confirmation
      disable_commit_confirmation = false,

      -- Use telescope for selection when available
      use_telescope = true,

      -- Kind of integration with other Git tools
      integrations = {
        diffview = true,
        telescope = true,
      },
    },
  },
}