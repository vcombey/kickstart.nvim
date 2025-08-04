-- AI-powered development assistance
return {
  { -- AI-powered code assistant with chat and editing capabilities
    -- Avante.nvim provides advanced AI assistance directly in Neovim
    -- Features include: code completion, chat interface, code editing suggestions,
    -- and intelligent refactoring - essentially bringing GitHub Copilot-like features
    -- with additional chat functionality for more interactive AI assistance
    'yetone/avante.nvim',

    -- Load when editing files (when you actually need AI assistance)
    event = 'VeryLazy',

    -- Use stable releases for reliability
    version = false, -- Set to false to use latest features, or specify version like "v0.1.0"

    -- Load when explicitly triggered (remove automatic keys to avoid conflicts)
    cmd = { 'AvanteToggle', 'AvanteAsk', 'AvanteEdit', 'AvanteRefresh', 'AvanteFocus' },

    opts = {
      -- 🎯 CURSOR-LIKE EXPERIENCE - Minimal & Clean
      provider = 'claude',

      providers = {
        claude = {
          endpoint = 'https://api.anthropic.com',
          model = 'claude-sonnet-4-20250514',
          timeout = 30000,
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 20480,
          },
          api_key_name = 'AVANTE_ANTHROPIC_API_KEY',
        },
      },

      -- Cursor-style clean interface
      windows = {
        position = 'right',
        width = 40,
        wrap = true,
        input = {
          height = 8, -- Multiline prompt by default
          min_height = 4,
          max_height = 20, -- Extensible
          auto_resize = true,
        },
      },

      -- Simple behavior like Cursor
      behaviour = {
        auto_suggestions = false, -- Keep it simple like Cursor
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false, -- Fix clipboard issues
      },

      -- Let avante use default mappings to avoid nil errors
      -- We'll override the submit key in a safer way

      -- Disable ALL UI clutter completely
      hints = { enabled = false },
      repo_map = { enabled = false }, -- No todos
      input_hints = { enabled = false },
      show_input_hint = false, -- Disable the function causing the error

      -- Hide token counts and progress
      ui = {
        show_tokens = false, -- No token indication
        show_model = false, -- No model name showing
        show_datetime = false, -- No datetime
        show_progress = false, -- No progress indicators
      },

      -- Clean sidebar without footer/header
      sidebar = {
        header = { enabled = false }, -- No header
        footer = { enabled = false }, -- No footer
        title = '', -- No title
      },

      debug = false,
    },

    -- Minimal dependencies for Cursor-like experience
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      {
        'stevearc/dressing.nvim', -- Clean input dialogs
        opts = {
          input = {
            enabled = true,
            start_mode = 'insert',
            border = 'rounded',
            relative = 'cursor',
          },
        },
        config = function(_, opts)
          require('dressing').setup(opts)
        end,
      },
      'nvim-tree/nvim-web-devicons', -- Icons
    },

    -- Simplified configuration function
    config = function(_, opts)
      -- Simple setup with error handling
      local ok, avante = pcall(require, 'avante')
      if not ok then
        vim.notify('Failed to load avante.nvim: ' .. tostring(avante), vim.log.levels.ERROR)
        return
      end

      local setup_ok, err = pcall(avante.setup, opts)
      if not setup_ok then
        vim.notify('Failed to setup avante.nvim: ' .. tostring(err), vim.log.levels.ERROR)
        return
      end

      -- Simple Cursor-like keymaps
      vim.schedule(function()
        local opts = { noremap = true, silent = true }

        -- Main AI chat (like Cursor's cmd+i)
        vim.keymap.set('n', '<leader>aa', '<cmd>AvanteToggle<cr>', vim.tbl_extend('force', opts, { desc = '🤖 AI Chat (Cursor-style)' }))

        -- Quick AI access from any mode (like Cursor's quick AI)
        vim.keymap.set({ 'n', 'v', 'i' }, '<D-;>', '<cmd>AvanteAsk<cr>', vim.tbl_extend('force', opts, { desc = '⚡ Quick AI Chat' }))

        -- AI code editing (like Cursor's inline AI)
        vim.keymap.set({ 'n', 'v' }, '<leader>ae', '<cmd>AvanteEdit<cr>', vim.tbl_extend('force', opts, { desc = '✨ AI Edit Code' }))
      end)
    end,

    -- Simple build step
    build = vim.fn.has 'win32' ~= 0 and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false' or 'make',
  },
}