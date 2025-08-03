-- Telescope fuzzy finder and search functionality
return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Command Palette - VS Code style Cmd+Shift+P equivalent
      -- This gives you access to ALL available commands, functions, and actions
      vim.keymap.set('n', '<leader>p', builtin.commands, { desc = '🎯 Command Palette (All Commands)' })

      -- Alternative command palette with more options
      vim.keymap.set('n', '<leader>P', function()
        builtin.commands {
          prompt_title = '🎯 Command Palette - All Available Commands',
          layout_config = {
            width = 0.8,
            height = 0.8,
            preview_cutoff = 120,
          },
        }
      end, { desc = '🎯 Enhanced Command Palette' })

      -- Quick access to specific command categories
      vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
      vim.keymap.set('n', '<leader>sp', function()
        -- Search through all Telescope pickers (meta!)
        builtin.builtin {
          prompt_title = '🔭 Telescope Pickers',
          include_extensions = true,
        }
      end, { desc = '[S]earch [P]ickers (Telescope)' })

      -- Enhanced Command Palette functionality
      -- This creates a mega command palette with multiple categories
      vim.keymap.set('n', '<C-S-P>', function() -- Ctrl+Shift+P (closest to Cmd+Shift+P)
        local actions = require 'telescope.actions'
        local action_state = require 'telescope.actions.state'
        local finders = require 'telescope.finders'
        local pickers = require 'telescope.pickers'
        local conf = require('telescope.config').values

        -- Define command categories like VS Code
        local command_categories = {
          {
            category = '📋 General Commands',
            picker = function()
              builtin.commands()
            end,
            desc = 'All Vim/Neovim commands',
          },
          {
            category = '🔑 Keymaps',
            picker = function()
              builtin.keymaps()
            end,
            desc = 'Search all keymaps',
          },
          {
            category = '📁 Files',
            picker = function()
              builtin.find_files()
            end,
            desc = 'Find files in project',
          },
          {
            category = '🔍 Search Text',
            picker = function()
              builtin.live_grep()
            end,
            desc = 'Search text in project',
          },
          {
            category = '📚 Help Tags',
            picker = function()
              builtin.help_tags()
            end,
            desc = 'Search help documentation',
          },
          {
            category = '🔧 LSP Actions',
            picker = function()
              vim.lsp.buf.code_action()
            end,
            desc = 'Code actions for current buffer',
          },
          {
            category = '📊 Diagnostics',
            picker = function()
              builtin.diagnostics()
            end,
            desc = 'Show project diagnostics',
          },
          {
            category = '🎯 Telescope Pickers',
            picker = function()
              builtin.builtin()
            end,
            desc = 'All Telescope pickers',
          },
          {
            category = '📜 Command History',
            picker = function()
              builtin.command_history()
            end,
            desc = 'Recent command history',
          },
          {
            category = '🔄 Recent Files',
            picker = function()
              builtin.oldfiles()
            end,
            desc = 'Recently opened files',
          },
          {
            category = '💾 Buffers',
            picker = function()
              builtin.buffers()
            end,
            desc = 'Open buffers',
          },
          {
            category = '📝 Registers',
            picker = function()
              builtin.registers()
            end,
            desc = 'Vim registers content',
          },
          {
            category = '🏷️ Tags',
            picker = function()
              builtin.tags()
            end,
            desc = 'Project tags (if available)',
          },
          {
            category = '🌿 Git Files',
            picker = function()
              builtin.git_files()
            end,
            desc = 'Git tracked files',
          },
          {
            category = '📈 Git Status',
            picker = function()
              builtin.git_status()
            end,
            desc = 'Git status',
          },
        }

        pickers
          .new({}, {
            prompt_title = '🎯 Command Palette - Choose Category',
            finder = finders.new_table {
              results = command_categories,
              entry_maker = function(entry)
                return {
                  value = entry,
                  display = entry.category .. ' - ' .. entry.desc,
                  ordinal = entry.category .. ' ' .. entry.desc,
                }
              end,
            },
            sorter = conf.generic_sorter {},
            attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                selection.value.picker()
              end)
              return true
            end,
          })
          :find()
      end, { desc = '🎯 Mega Command Palette (Categories)' })

      -- Additional VS Code-like shortcuts for familiar workflow
      -- These provide quick access to common actions without going through the command palette

      -- Quick Open (Ctrl+P / Cmd+P equivalent)
      vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = '📁 Quick Open Files' })

      -- Search everywhere (Ctrl+Shift+F / Cmd+Shift+F equivalent)
      vim.keymap.set('n', '<C-S-F>', builtin.live_grep, { desc = '🔍 Search Everywhere' })

      -- Go to symbol in workspace (Ctrl+T / Cmd+T equivalent)
      vim.keymap.set('n', '<C-t>', function()
        -- Try workspace symbols first, fall back to document symbols
        local clients = vim.lsp.get_clients()
        if #clients > 0 then
          builtin.lsp_workspace_symbols()
        else
          builtin.treesitter()
        end
      end, { desc = '🎯 Go to Symbol in Workspace' })

      -- Go to symbol in file (Ctrl+Shift+O / Cmd+Shift+O equivalent)
      vim.keymap.set('n', '<C-S-O>', function()
        -- Try LSP document symbols first, fall back to treesitter
        local clients = vim.lsp.get_clients()
        if #clients > 0 then
          builtin.lsp_document_symbols()
        else
          builtin.treesitter()
        end
      end, { desc = '📋 Go to Symbol in File' })

      -- Command history (useful for repeating complex commands)
      vim.keymap.set('n', '<leader>;', builtin.command_history, { desc = '📜 Command History' })

      -- Search history (useful for repeating searches)
      vim.keymap.set('n', '<leader>:', builtin.search_history, { desc = '🔍 Search History' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = {},
      },

      -- Document existing key chains for better organization and discoverability
      -- Which-key will show these group descriptions when you press the leader key
      -- This makes it much easier to discover and remember keymaps
      spec = {
        { '<leader>s', group = '[S]earch' }, -- Telescope search functions
        { '<leader>t', group = '[T]oggle' }, -- Toggle various features
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Git hunk operations
        { '<leader>g', group = '[G]it' }, -- Git operations
        { '<leader>b', group = '[B]uffer' }, -- Buffer managemmnt
        { '<leader>f', group = '[F]ormat' }, -- Code formatting
        { '<leader>w', group = '[W]orkspace' }, -- Workspace operations
        { '<leader>d', group = '[D]iagnostics' }, -- LSP diagnostics
        { '<leader>c', group = '[C]ode' }, -- Code actions
        { '<leader>l', group = '[L]SP' }, -- LSP management
        { '<leader>x', group = 'E[x]it/Close' }, -- Close operations
        { '<leader>v', group = '[V]ertical Split' }, -- Window splitting
        { '<leader>a', group = '🤖 AI Assistant (Cursor-style)' }, -- Clean AI assistance like Cursor
        { '<C-;>', desc = '⚡ Quick AI Chat' }, -- Quick AI access like Cursor
        { '<leader>p', desc = '🎯 Command Palette' }, -- VS Code style command palette
        { '<leader>P', desc = '🎯 Enhanced Command Palette' }, -- Enhanced command palette
        { '<C-S-P>', desc = '🎯 Mega Command Palette (Categories)' }, -- Ctrl+Shift+P like VS Code
        { '<C-p>', desc = '📁 Quick Open Files' }, -- Ctrl+P like VS Code
        { '<C-S-F>', desc = '🔍 Search Everywhere' }, -- Ctrl+Shift+F like VS Code
        { '<C-t>', desc = '🎯 Go to Symbol in Workspace' }, -- Ctrl+T like VS Code
        { '<C-S-O>', desc = '📋 Go to Symbol in File' }, -- Ctrl+Shift+O like VS Code
        { '<C-x>g', desc = '🌿 Open Neogit' }, -- Git interface like Magit
        { '<leader>;', desc = '📜 Command History' }, -- Command history
        { '<leader>:', desc = '🔍 Search History' }, -- Search history
      },
    },
  },
}