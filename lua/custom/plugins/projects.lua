-- Project and workspace management for VSCode-like experience
return {
  { -- Project management and detection
    'ahmedkhalf/project.nvim',
    event = 'VeryLazy',
    config = function()
      require('project_nvim').setup {
        -- Detection methods to identify the root of the project
        -- These patterns help automatically detect project roots
        detection_methods = { 'lsp', 'pattern' },

        -- Patterns to look for to identify project roots
        -- Add/remove patterns based on your project types
        patterns = {
          '.git',
          '_darcs',
          '.hg',
          '.bzr',
          '.svn',
          'Makefile',
          'package.json',
          'Cargo.toml',
          'go.mod',
          'pyproject.toml',
          'pom.xml',
          '.project',
          '.pro',
          -- Haskell project patterns
          'stack.yaml',
          'cabal.project',
          '*.cabal',
        },

        -- Table of lsp clients to ignore by name
        -- eg: { "efm", ... }
        ignore_lsp = {},

        -- Don't calculate root dir on specific directories
        -- Global gitignore here would be unwise
        exclude_dirs = {},

        -- Show hidden files in telescope
        show_hidden = false,

        -- When set to false, you will get a message when project.nvim hasn't found your project
        silent_chdir = true,

        -- What scope to change the directory, valid options are
        -- * global (default)
        -- * tab
        -- * win
        scope_chdir = 'global',

        -- Path where project.nvim will store the project history for use in telescope
        datapath = vim.fn.stdpath 'data',
      }
    end,
  },

  { -- Enhanced telescope integration for projects
    'nvim-telescope/telescope-project.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'ahmedkhalf/project.nvim',
    },
    config = function()
      -- Load the project extension for telescope
      require('telescope').load_extension 'project'

      -- Keymaps for project management
      local builtin = require 'telescope.builtin'

      -- Main project picker - shows recent projects
      vim.keymap.set('n', '<leader>fp', function()
        require('telescope').extensions.project.project {
          display_type = 'full',
          theme = 'dropdown',
          previewer = false,
        }
      end, { desc = '📁 Find [P]rojects (Recent Workspaces)' })

      -- Add current directory as a project
      vim.keymap.set('n', '<leader>pa', function()
        require('project_nvim.project').add_project()
        print '✅ Added current directory to projects'
      end, { desc = '[P]roject [A]dd current directory' })

      -- Remove current project from history
      vim.keymap.set('n', '<leader>pr', function()
        require('project_nvim.project').delete_project()
        print '🗑️ Removed current project from history'
      end, { desc = '[P]roject [R]emove from history' })

      -- Open project in current window
      vim.keymap.set('n', '<leader>po', function()
        require('telescope').extensions.project.project {
          action = function(selection)
            -- Change to the project directory
            vim.cmd('cd ' .. selection.path)
            -- Close any open file tree
            vim.cmd 'Neotree close'
            -- Open file tree in new project
            vim.cmd 'Neotree show'
            print('📁 Switched to project: ' .. selection.name)
          end,
        }
      end, { desc = '[P]roject [O]pen in current window' })
    end,
  },

  { -- Auto-session management for projects
    'rmagatti/auto-session',
    lazy = false,
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('auto-session').setup {
        -- Enable logging for debugging
        log_level = 'error',

        -- Auto save session
        auto_save_enabled = true,

        -- Auto restore session
        auto_restore_enabled = true,

        -- Auto create session
        auto_create_enabled = false,

        -- Session save location
        auto_session_root_dir = vim.fn.stdpath 'data' .. '/sessions/',

        -- Files to ignore when creating sessions
        auto_session_suppress_dirs = {
          '~/',
          '~/Projects',
          '~/Downloads',
          '/',
          '/tmp',
        },

        -- Integration with project.nvim
        auto_session_use_git_branch = true,

        -- Session lens (telescope integration)
        session_lens = {
          -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
          buftypes_to_ignore = {},
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
        },

        -- Pre and post hooks
        pre_save_cmds = {
          'Neotree close', -- Close file tree before saving session
          'cclose', -- Close quickfix
          'lclose', -- Close location list
        },

        post_restore_cmds = {
          'Neotree show', -- Reopen file tree after restoring
        },
      }

      -- Keymaps for session management
      vim.keymap.set('n', '<leader>fs', function()
        require('telescope').extensions.session_lens.search_session()
      end, { desc = '[F]ind [S]essions' })

      vim.keymap.set('n', '<leader>ss', function()
        require('auto-session').SaveSession()
        print '💾 Session saved'
      end, { desc = '[S]ave [S]ession' })

      vim.keymap.set('n', '<leader>sr', function()
        require('auto-session').RestoreSession()
        print '🔄 Session restored'
      end, { desc = '[S]ession [R]estore' })

      vim.keymap.set('n', '<leader>sd', function()
        require('auto-session').DeleteSession()
        print '🗑️ Session deleted'
      end, { desc = '[S]ession [D]elete' })
    end,
  },
}

