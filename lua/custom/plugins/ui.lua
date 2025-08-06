-- UI-related plugins for better visual experience
return {
  { -- Status line with Git integration and LSP information
    -- Lualine provides a beautiful and informative status line at the bottom of your screen
    -- It replaces the default Neovim status line with something much more useful
    'nvim-lualine/lualine.nvim',

    -- Load this plugin after other UI elements are loaded to avoid flicker
    -- 'VeryLazy' means it loads after the initial startup process
    event = 'VeryLazy',

    -- Configuration options for lualine
    opts = {
      options = {
        -- 'auto' automatically detects and uses the theme from your colorscheme
        -- This ensures the status line matches your current theme
        theme = 'auto',

        -- Component separators appear between different sections
        -- Using simple characters for a clean, modern look
        component_separators = { left = '', right = '' },

        -- Section separators create distinct visual sections
        -- These create the "powerline" style appearance
        section_separators = { left = '', right = '' },
      },

      -- Sections define what information appears where on the status line
      -- The status line is divided into left (a,b,c) and right (x,y,z) sections
      sections = {
        -- Section A (leftmost): Current Vim mode (NORMAL, INSERT, VISUAL, etc.)
        lualine_a = { 'mode' },

        -- Section B: Git information and diagnostics
        -- 'branch' shows current git branch
        -- 'diff' shows git changes (+3 ~1 -2)
        -- 'diagnostics' shows LSP errors/warnings
        lualine_b = { 'branch', 'diff', 'diagnostics' },

        -- Section C: Current filename
        -- This is the main content area
        lualine_c = { 'filename' },

        -- Section X: File information
        -- 'encoding' shows file encoding (utf-8, etc.)
        -- 'fileformat' shows line endings (unix, dos, mac)
        -- 'filetype' shows the detected file type
        lualine_x = { 'encoding', 'fileformat', 'filetype' },

        -- Section Y: File progress (percentage through file)
        lualine_y = { 'progress' },

        -- Section Z (rightmost): Cursor location (line:column)
        lualine_z = { 'location' },
      },

      -- Extensions for specific filetypes to customize lualine behavior
      extensions = {
        {
          -- Disable status line sections for NeoTree and Avante windows
          sections = {},
          filetypes = { 'neo-tree', 'AvanteInput', 'AvanteTodos', 'Avante', 'AvanteSelectedFiles', 'toggleterm' },
        },
      },
    },
  },

  { -- Buffer tabs at the top of the screen
    -- Bufferline shows your open buffers as tabs at the top, similar to browser tabs
    -- This makes it easy to see and switch between multiple open files
    'akinsho/bufferline.nvim',

    -- Load after initial startup to avoid interfering with the startup screen
    event = 'VeryLazy',

    -- Key mappings specific to this plugin
    -- These override the global Tab mappings we set earlier for better integration
    keys = {
      { '<C-l>', '<Cmd>BufferLineCycleNext<CR>', desc = 'Next tab' },
      { '<C-h>', '<Cmd>BufferLineCyclePrev<CR>', desc = 'Prev tab' },
    },

    opts = {
      options = {
        -- 'buffers' mode shows actual Neovim buffers (files in memory)
        -- Alternative is 'tabs' which shows Neovim tab pages
        mode = 'buffers',

        -- 'slant' creates angled separators between tabs for a modern look
        -- Other options: 'thin', 'thick', 'padded_slant'
        separator_style = 'slant',

        -- false = only show bufferline when there are 2+ buffers
        -- true = always show it (even with just one buffer)
        always_show_bufferline = true,

        -- Hide close buttons on individual buffers for a cleaner look
        -- You can still close buffers with `:bdelete` or our <leader>bd mapping
        show_buffer_close_icons = false,
        show_close_icon = false,

        -- Show file type icons if you have a Nerd Font installed
        -- This uses nvim-web-devicons to show appropriate icons for each file type
        color_icons = true,
      },
    },
  },

  { -- Welcome screen with quick actions
    -- Dashboard provides a beautiful startup screen when you open Neovim without a file
    -- Similar to the welcome screens in VSCode, Atom, or other modern editors
    'nvimdev/dashboard-nvim',

    -- Load immediately when Neovim starts (VimEnter event)
    -- This ensures the dashboard appears right away
    event = 'VimEnter',

    -- Configuration is a function because we need to dynamically generate some content
    opts = function()
      -- ASCII art logo for the dashboard
      -- This creates a nice visual header - you can customize this with any ASCII art
      -- Tools like 'figlet' can generate ASCII text, or you can create custom designs
      local logo = [[
      ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
      ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
      ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
      ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
      ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]

      -- Add padding above and below the logo for better visual spacing
      logo = string.rep('\n', 8) .. logo .. '\n\n'

      local opts = {
        -- 'doom' theme provides a centered layout similar to Doom Emacs
        -- Other options include 'hyper' for a different style
        theme = 'doom',

        hide = {
          -- Keep the status line visible even on the dashboard
          -- This maintains consistency with the rest of your Neovim experience
          statusline = false,
        },

        config = {
          -- Convert the logo string into individual lines for display
          header = vim.split(logo, '\n'),

          -- Center section contains the main action buttons
          -- Each button has an action (command to run), description, icon, and key
          center = {
            -- Find files in current directory using Telescope
            { action = 'Telescope find_files', desc = ' Find File', icon = ' ', key = 'f' },

            -- Create a new empty buffer and enter insert mode
            { action = 'ene | startinsert', desc = ' New File', icon = ' ', key = 'n' },

            -- Show recently opened files
            { action = 'Telescope oldfiles', desc = ' Recent Files', icon = ' ', key = 'r' },

            -- Search for text across all files in the project
            { action = 'Telescope live_grep', desc = ' Find Text', icon = ' ', key = 'g' },

            -- Quick access to Neovim configuration files
            { action = 'Telescope find_files cwd=~/.config/nvim', desc = ' Config', icon = ' ', key = 'c' },

            -- Open the file explorer (also available with Ctrl+n)
            { action = 'Neotree toggle', desc = ' Explorer', icon = ' ', key = 'e' },

            -- Open the plugin manager
            { action = 'Lazy', desc = ' Lazy', icon = '󰒲 ', key = 'l' },

            -- Quit Neovim
            { action = 'qa', desc = ' Quit', icon = ' ', key = 'q' },
          },

          -- Footer shows plugin loading statistics
          -- This function runs each time the dashboard is displayed
          footer = function()
            local stats = require('lazy').stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
          end,
        },
      }

      -- Format the center buttons for consistent spacing and appearance
      for _, button in ipairs(opts.config.center) do
        -- Add padding to make all descriptions the same width
        button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
        -- Format how the key is displayed next to the description
        button.key_format = '  %s'
      end

      -- Special handling if Lazy plugin manager is already open
      -- This prevents conflicts between the dashboard and Lazy UI
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'DashboardLoaded',
          callback = function()
            require('lazy').show()
          end,
        })
      end

      return opts
    end,
  },

  { -- Integrated terminal that floats over your code
    -- ToggleTerm provides a better terminal experience than Neovim's built-in terminal
    -- It can show terminals in floating windows, splits, or tabs
    'akinsho/toggleterm.nvim',

    -- Only load when we actually need terminal commands
    -- This improves startup time since terminals aren't needed immediately
    cmd = { 'ToggleTerm', 'TermExec' },

    -- Keymaps for different terminal styles
    keys = {
      -- Floating terminal (appears over your code like a dropdown)
      { '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', desc = 'Terminal (float)' },

      -- Horizontal split terminal (appears at bottom)
      { '<leader>th', '<cmd>ToggleTerm direction=horizontal<cr>', desc = 'Terminal (horizontal)' },

      -- Vertical split terminal (appears on the side)
      { '<leader>tv', '<cmd>ToggleTerm direction=vertical size=80<cr>', desc = 'Terminal (vertical)' },
    },

    opts = {
      -- Size for horizontal/vertical terminals (lines for horizontal, columns for vertical)
      size = 20,

      -- Hide line numbers in terminal windows (they're not useful there)
      hide_numbers = true,

      -- Add a subtle background to terminals to distinguish them
      shade_terminals = true,
      shading_factor = 2, -- How much darker to make the background

      -- Start in insert mode (so you can type immediately)
      start_in_insert = true,

      -- Allow terminal to respond to insert mode key mappings
      insert_mappings = true,

      -- Remember terminal size between sessions
      persist_size = true,

      -- Default direction when using `:ToggleTerm` without arguments
      direction = 'float',

      -- Automatically close terminal when the process exits
      close_on_exit = true,

      -- Use the system shell (respects your SHELL environment variable)
      shell = vim.o.shell,

      -- Configuration for floating terminals
      float_opts = {
        -- 'curved' borders look modern and friendly
        -- Other options: 'single', 'double', 'shadow', 'solid', 'rounded'
        border = 'curved',

        -- winblend controls transparency (0 = opaque, 100 = invisible)
        winblend = 0,

        -- Color scheme for the terminal border and background
        highlights = {
          border = 'Normal', -- Use normal text color for border
          background = 'Normal', -- Use normal background color
        },
      },
    },
  },

  { -- Modern file explorer with Git integration
    -- Neo-tree is a modern file explorer that can show files, buffers, git status, and more
    -- It's more feature-rich than the built-in netrw explorer
    'nvim-neo-tree/neo-tree.nvim',

    -- Use the v3.x branch for the latest stable features
    branch = 'v3.x',

    -- Only load when explicitly requested (improves startup time)
    cmd = 'Neotree',

    -- Key mappings for different Neo-tree modes
    keys = {
      -- Toggle file explorer in the current directory with Ctrl+n
      -- This is a common keymap used in many editors like VSCode
      { '<C-n>', '<cmd>Neotree toggle<cr>', desc = 'Toggle NeoTree Explorer' },

      -- Toggle floating file explorer (appears over your code)
      { '<leader>E', '<cmd>Neotree toggle float<cr>', desc = 'Explorer NeoTree (float)' },
    },

    -- Function to run when the plugin is deactivated
    deactivate = function()
      vim.cmd [[Neotree close]]
    end,

    -- Auto-open Neo-tree if Neovim is started with a directory argument
    init = function()
      -- Check if exactly one argument was passed to Neovim
      if vim.fn.argc(-1) == 1 then
        -- Check if that argument is a directory
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == 'directory' then
          -- Load Neo-tree to handle the directory
          require 'neo-tree'
        end
      end
    end,

    opts = {
      -- Different views available in Neo-tree
      -- 'filesystem' = traditional file browser
      -- 'buffers' = list of open buffers
      -- 'git_status' = git changes overview
      -- 'document_symbols' = LSP symbols in current file
      sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },

      -- Prevent Neo-tree from replacing certain special buffer types
      -- This ensures terminals, diagnostics, etc. don't get replaced by the file tree
      open_files_do_not_replace_types = { 'terminal', 'Trouble', 'trouble', 'qf', 'Outline' },

      filesystem = {
        -- Don't change Neovim's working directory when navigating
        -- This gives you more control over your project's root
        bind_to_cwd = false,

        -- Automatically expand to and highlight the current file
        -- Makes it easy to see where you are in the project structure
        follow_current_file = { enabled = true },

        -- Use libuv for file watching (better performance and reliability)
        -- Automatically refreshes when files are added/removed outside Neovim
        use_libuv_file_watcher = true,
      },

      window = {
        mappings = {
          -- Disable space key (we use it as leader elsewhere)
          ['<space>'] = 'none',

          -- Copy file path to system clipboard
          -- Useful for sharing file paths or using them in other applications
          ['Y'] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg('+', path, 'c') -- '+' register is system clipboard
            end,
            desc = 'Copy Path to Clipboard',
          },

          -- Open file/directory with system default application
          -- For example, open images in image viewer, PDFs in PDF reader
          ['O'] = {
            function(state)
              local path = state.tree:get_node().path
              vim.fn.jobstart({ 'open', path }, { detach = true }) -- macOS command
              -- For Linux, you might want: vim.fn.jobstart({'xdg-open', path}, {detach = true})
              -- For Windows: vim.fn.jobstart({'start', path}, {detach = true})
            end,
            desc = 'Open with System Application',
          },
        },
      },

      -- Configure how the tree structure is displayed
      default_component_configs = {
        indent = {
          -- Show expand/collapse indicators for directories
          with_expanders = true,

          -- Icons for collapsed and expanded directories
          -- These require a Nerd Font to display properly
          expander_collapsed = '', -- Right-pointing triangle
          expander_expanded = '', -- Down-pointing triangle
          expander_highlight = 'NeoTreeExpander',
        },
      },
    },

    -- Required dependencies for Neo-tree functionality
    dependencies = {
      'nvim-lua/plenary.nvim', -- Lua utility functions
      'nvim-tree/nvim-web-devicons', -- File type icons
      'MunifTanjim/nui.nvim', -- UI component library
    },

    -- Custom configuration function
    config = function(_, opts)
      require('neo-tree').setup(opts)

      -- Auto-refresh git status when lazygit (external git tool) closes
      -- This ensures the git status view stays up-to-date
      vim.api.nvim_create_autocmd('TermClose', {
        pattern = '*lazygit',
        callback = function()
          if package.loaded['neo-tree.sources.git_status'] then
            require('neo-tree.sources.git_status').refresh()
          end
        end,
      })
    end,
  },

  -- Better notifications
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      render = 'default',
      stages = 'fade_in_slide_out',
      background_colour = '#000000', -- Set background color to fix transparency warning
    },
    config = function(_, opts)
      require('notify').setup(opts)
      vim.notify = require 'notify'
    end,
  },
}
