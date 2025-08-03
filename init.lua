-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = false
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = false

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- cmdheight controls the number of screen lines to use for the command-line
-- Setting it to 1 gives a clean look while still showing important messages
-- See `:help 'cmdheight'`
vim.o.cmdheight = 1

-- pumheight sets the maximum number of items to show in the popup menu (for completions)
-- 10 is a good balance - not too overwhelming, but shows enough options
-- See `:help 'pumheight'`
vim.o.pumheight = 10

-- showtabline controls when the tabline is shown
-- 2 = always show tabline, even when there's only one tab
-- This provides consistent UI and shows buffer information
-- See `:help 'showtabline'`
vim.o.showtabline = 2

-- smartindent automatically indents new lines based on the previous line
-- This is especially useful for programming languages with block structures
-- See `:help 'smartindent'`
vim.o.smartindent = true

-- Disable swap files - they can be annoying in modern development
-- With version control and auto-save, swap files are less necessary
-- See `:help 'swapfile'`
vim.o.swapfile = false

-- termguicolors enables 24-bit RGB color in the terminal
-- This allows for much richer colors and better theme support
-- Make sure your terminal supports true colors!
-- See `:help 'termguicolors'`
vim.o.termguicolors = true

-- writebackup creates a backup before overwriting a file, then deletes it
-- We disable this for cleaner file management (version control handles this)
-- See `:help 'writebackup'`
vim.o.writebackup = false

-- expandtab converts tabs to spaces when typing
-- This ensures consistent indentation across different editors and systems
-- See `:help 'expandtab'`
vim.o.expandtab = true

-- shiftwidth sets the number of spaces to use for each step of (auto)indent
-- 2 spaces is common for many languages and provides good readability
-- See `:help 'shiftwidth'`
vim.o.shiftwidth = 2

-- tabstop sets the number of spaces that a tab character represents
-- Should match shiftwidth for consistency
-- See `:help 'tabstop'`
vim.o.tabstop = 2

-- numberwidth sets the minimal number of columns to use for line numbers
-- 4 provides enough space for most files while keeping it compact
-- See `:help 'numberwidth'`
vim.o.numberwidth = 4

-- wrap controls whether long lines are visually wrapped
-- Disabled for coding to see the actual line structure
-- You can toggle this with `:set wrap` if needed
-- See `:help 'wrap'`
vim.o.wrap = true

-- fillchars defines characters to use for various UI elements
-- eob: character for empty lines below the buffer (empty = cleaner look)
-- Using minimal settings to ensure compatibility across Neovim versions
-- See `:help 'fillchars'` for all available options
vim.o.fillchars = [[eob: ]]

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', 'jk', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-x>h', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-x>l', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-x>j', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-x>k', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<enter>', 'i', { desc = 'go to insert mode' })

-- Split current window vertically (creates a new window to the right)
-- Alternative to the default `:vsplit` or `<C-w>v`
-- TIP: Use this when you want to compare two files side by side
vim.keymap.set('n', '<leader>v', '<C-w>v', { desc = 'Split window vertically' })

-- Split current window horizontally (creates a new window below)
-- Alternative to the default `:split` or `<C-w>s`
-- TIP: Use this when you want to see two parts of the same file
vim.keymap.set('n', '<leader>h', '<C-w>s', { desc = 'Split window horizontally' })

-- Close current window (not the buffer, just the window)
-- Safer than `:q` as it won't close Neovim if it's the last window
-- See `:help CTRL-W_c` for more information
vim.keymap.set('n', '<leader>x', '<C-w>c', { desc = 'Close current window' })

-- [[ Buffer Management ]]
-- Buffers represent files loaded in memory. These keymaps make it easier
-- to navigate between different files without using the mouse

-- Navigate to next buffer in the buffer list
-- Much more convenient than `:bnext`
-- TIP: Buffers are like tabs in other editors, but more powerful
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = 'Next buffer' })

-- Navigate to previous buffer in the buffer list
-- Partner to the above keymap for easy buffer navigation
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { desc = 'Previous buffer' })

-- Delete/close the current buffer
-- Removes the file from memory but keeps the window open
-- See `:help :bdelete` for differences between bdelete, bwipeout, etc.
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete buffer' })

-- [[ Enhanced Text Editing ]]
-- These keymaps improve the text editing experience by maintaining
-- visual selection and providing better line movemlected line
-- gv reselects, = reformats the selection
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=g", { desc = 'Move line down' })

-- Move selected lines up
-- Similar to the above but moves lines up instead
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=g", { desc = 'Move line up' })

-- [[ Better Navigation with Centering ]]
-- These keymaps improve navigation by keeping the cursor centered
-- This reduces eye strain and makes it easier to maintain context

-- Half page down and center the cursor
-- 'zz' centers the current line in the window
-- This prevents the cursor from going to the bottom of the screen
--vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down and center' })

-- Half page up and center the cursor
-- Partner to the above for upward navigation
--vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up and center' })

-- Next search result and center
-- 'zzzv' centers the line and opens any closed folds
-- 'v' ensures we're in the right mode after the motion
--vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result and center' })

-- Previous search result and center
-- Partner to the above for backward search navigation
--vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result and center' })

-- [[ File Operations ]]
-- Quick access to common file operations

-- Save current file
-- Much faster than typing `:w<CR>`
-- TIP: This works even if the file is readonly (will show an error)
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })

-- Select all text in the current buffer
-- 'gg' goes to the first line, 'V' enters line-wise visual mode, 'G' goes to last line
-- Equivalent to Ctrl+A in most other editors
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select all' })

-- [[ Clipboard Management ]]
-- Better paste behavior that doesn't pollute your clipboard

-- Paste without replacing clipboard content
-- When you paste over selected text, the deleted text normally goes to clipboard
-- "_d deletes to the "black hole" register (doesn't affect clipboard)
-- P pastes before the cursor
vim.keymap.set('x', 'p', '"_dP', { desc = 'Paste without replacing clipboard' })

-- [[ LSP and Tool Management ]]
-- Quick access to development tools and language server information

-- Show LSP information for the current buffer
-- Displays which language servers are attached, their status, and capabilities
-- Very useful for debugging LSP issues
vim.keymap.set('n', '<leader>li', '<cmd>LspInfo<cr>', { desc = 'LSP Info' })

-- Restart all LSP clients for the current buffer
-- Useful when language servers get stuck or need to reload configuration
vim.keymap.set('n', '<leader>lr', '<cmd>LspRestart<cr>', { desc = 'LSP Restart' })

-- Open Mason tool installer
-- Mason manages LSP servers, formatters, linters, and other external tools
-- See `:help mason.nvim` for more information
vim.keymap.set('n', '<leader>cm', '<cmd>Mason<cr>', { desc = 'Mason' })

-- Open Lazy plugin manager
-- Lazy is our plugin manager - use this to install, update, or remove plugins
-- See `:help lazy.nvim` for more information
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })
vim.keymap.set('n', '<C-j>', '<cmd>ToggleTerm direction=horizontal<cr>', { desc = 'Lazy' })
vim.keymap.set('i', '<C-j>', '<cmd>ToggleTerm direction=horizontal<cr>', { desc = 'Lazy' })
vim.keymap.set('t', '<C-j>', '<cmd>ToggleTerm direction=horizontal<cr>', { desc = 'Lazy' })

-- [[ Neovide Configuration ]]
-- Check if running in Neovide and apply specific settings
if vim.g.neovide then
  -- Disable animations for better performance and less distraction
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_hide_mouse_when_typing = true

  -- Font scaling keymaps (Cmd+ and Cmd-)
  vim.keymap.set({'n', 'i', 'v'}, '<D-=>', function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
  end, { desc = 'Increase font size' })

  vim.keymap.set({'n', 'i', 'v'}, '<D-->', function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 0.9
  end, { desc = 'Decrease font size' })

  -- Reset font size
  vim.keymap.set({'n', 'i', 'v'}, '<D-0>', function()
    vim.g.neovide_scale_factor = 1.0
  end, { desc = 'Reset font size' })

  -- Set Anthropic API key for AI features (if you're using any AI plugins)
  -- You can set this environment variable in your shell profile or here
  if not vim.env.ANTHROPIC_API_KEY then
    -- Replace 'your-api-key-here' with your actual API key
    -- Or better yet, create a ~/.config/nvim/anthropic_key.lua file with:
    -- return "your-actual-api-key"
    local ok, api_key = pcall(function()
      return require('anthropic_key')
    end)
    if ok and api_key then
      vim.env.ANTHROPIC_API_KEY = api_key
    else
      -- Fallback: uncomment and add your key directly (less secure)
      -- vim.env.ANTHROPIC_API_KEY = "your-api-key-here"
    end
  end
end

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
--vim.api.nvim_create_autocmd('TextYankPost', {
--  desc = 'Highlight when yanking (copying) text',
--  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
--  callback = function()
--    vim.hl.on_yank()
--  end,
--})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

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

  -- [[ Text Objects and Motion Enhancement ]]
  -- Text objects are one of Vim's most powerful features for precise text editing
  -- They allow you to operate on logical units like words, sentences, paragraphs, etc.

  { -- Advanced and customizable text objects
    -- Mini.ai extends Neovim's built-in text objects with many more useful ones
    -- Text objects work with operators: d(elete), c(hange), y(ank), v(isual select)
    -- Format: [operator][a/i][text-object]
    -- Examples: daw = delete a word, ci" = change inside quotes, yap = yank a paragraph
    'echasnovski/mini.ai',

    -- Load after other plugins to ensure treesitter is available
    event = 'VeryLazy',

    -- Configuration function to set up custom text objects
    opts = function()
      local ai = require 'mini.ai'
      return {
        -- How many lines to search for text objects (prevents hanging on huge files)
        n_lines = 500,

        -- Custom text objects using treesitter (syntax-aware)
        custom_textobjects = {
          -- 'o' for code block objects (if/else, loops, functions, etc.)
          -- 'a' includes surrounding whitespace, 'i' only includes inner content
          o = ai.gen_spec.treesitter({
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }, {}),

          -- 'f' for function objects
          -- Examples: daf = delete entire function, cif = change function body
          f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),

          -- 'c' for class objects
          -- Examples: dac = delete entire class, cic = change class body
          c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),

          -- 't' for HTML/XML tag objects
          -- Examples: dat = delete entire tag, cit = change tag content
          t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
        },
      }
    end,
  },

  { -- Surround operations (add, delete, replace quotes, brackets, etc.)
    -- Mini.surround makes it easy to work with surroundings like quotes, brackets, tags
    -- This is incredibly useful for programming and text editing
    'echasnovski/mini.surround',

    -- Dynamic key setup to integrate with which-key descriptions
    keys = function(_, keys)
      local plugin = require('lazy.core.config').spec.plugins['mini.surround']
      local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
      local mappings = {
        -- Add surrounding around text object or visual selection
        -- Example: gsaiw" adds quotes around current word
        { opts.mappings.add, desc = 'Add surrounding', mode = { 'n', 'v' } },

        -- Delete surrounding characters
        -- Example: gsd" deletes surrounding quotes
        { opts.mappings.delete, desc = 'Delete surrounding' },

        -- Find next surrounding character to the right
        { opts.mappings.find, desc = 'Find right surrounding' },

        -- Find next surrounding character to the left
        { opts.mappings.find_left, desc = 'Find left surrounding' },

        -- Highlight surrounding characters (useful for visual feedback)
        { opts.mappings.highlight, desc = 'Highlight surrounding' },

        -- Replace one surrounding with another
        -- Example: gsr"' replaces quotes with single quotes
        { opts.mappings.replace, desc = 'Replace surrounding' },

        -- Update how many lines to search (rarely needed)
        { opts.mappings.update_n_lines, desc = 'Update `MiniSurround.config.n_lines`' },
      }

      -- Filter out any empty mappings
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)

      return vim.list_extend(mappings, keys)
    end,

    opts = {
      -- Custom keymaps for surround operations
      -- Using 'gs' prefix to avoid conflicts with default Vim keymaps
      mappings = {
        add = 'gsa', -- Add surrounding
        delete = 'gsd', -- Delete surrounding
        find = 'gsf', -- Find surrounding
        find_left = 'gsF', -- Find surrounding left
        highlight = 'gsh', -- Highlight surrounding
        replace = 'gsr', -- Replace surrounding
        update_n_lines = 'gsn', -- Update search lines
      },
    },
  },

  -- [[ Code Quality and Formatting Plugins ]]
  -- These plugins improve code readability and help maintain consistent formatting

  { -- Smart commenting with language awareness
    -- Comment.nvim provides intelligent commenting for any language
    -- It automatically detects the correct comment syntax and handles edge cases
    'numToStr/Comment.nvim',

    -- Load when we start editing (VeryLazy = after initial UI setup)
    event = 'VeryLazy',

    -- Default configuration works great out of the box
    -- Key mappings:
    -- gcc = toggle line comment
    -- gbc = toggle block comment
    -- gc in visual mode = comment selection
    -- gb in visual mode = block comment selection
    opts = {},
  },

  { -- Automatic bracket/quote pairing
    -- Automatically adds closing brackets, quotes, etc. when you type the opening one
    -- Also provides smart deletion and navigation within pairs
    'windwp/nvim-autopairs',

    -- Only load when entering insert mode (when you actually need it)
    event = 'InsertEnter',

    -- Default configuration provides sensible pairing for:
    -- Brackets: ( ) [ ] { }
    -- Quotes: ' " `
    -- HTML tags: < >
    -- And many language-specific pairs
    opts = {},
  },

  { -- Visual indentation guides
    -- Shows vertical lines to help visualize indentation levels
    -- Especially useful for languages like Python or deeply nested code
    'lukas-reineke/indent-blankline.nvim',

    -- Load after initial setup since it's a visual enhancement
    event = 'VeryLazy',

    opts = {
      indent = {
        -- Character to use for indent guides (requires Nerd Font)
        char = ' ', -- Vertical line character
        tab_char = ' ', -- Same character for tab indentation
      },
      -- char = '│', -- Vertical line character
      -- tab_char = '│', -- Same character for tab indentation

      -- Disable scope highlighting (can be distracting)
      -- Scope would highlight the current indentation level
      scope = { enabled = false },

      -- Don't show indent guides in certain file types where they're not useful
      exclude = {
        filetypes = {
          'help', -- Help documentation
          'alpha', -- Alpha dashboard
          'dashboard', -- Dashboard plugin
          'neo-tree', -- File explorer
          'Trouble', -- Diagnostics
          'trouble', -- Diagnostics (lowercase)
          'lazy', -- Plugin manager
          'mason', -- Tool installer
          'notify', -- Notifications
          'toggleterm', -- Terminal
          'lazyterm', -- Lazy terminal
        },
      },
    },

    -- Use 'ibl' as the main module (new name for indent-blankline)
    main = 'ibl',
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

  -- Todo comments
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },

  { -- Enhanced text objects for better code navigation
    -- Provides additional text objects beyond the built-in ones
    -- These work great with Haskell's functional programming constructs
    'kana/vim-textobj-user',

    -- Load related text object plugins
    dependencies = {
      -- 'ae' and 'ie' text objects for entire buffer
      -- Useful for operations on the whole file
      { 'kana/vim-textobj-entire' },

      -- 'al' and 'il' text objects for current line
      -- Handy for line-based operations
      { 'kana/vim-textobj-line' },

      -- 'ai' and 'ii' text objects for same indentation level
      -- Perfect for Haskell's indentation-sensitive syntax
      { 'kana/vim-textobj-indent' },
    },
  },

  { -- Unicode symbol concealing for Haskell (as specifically requested)
    -- Replaces Haskell operators with Unicode symbols for better readability
    -- Examples: -> becomes →, <= becomes ≤, forall becomes ∀, :: becomes ∷
    -- This makes Haskell code more mathematical and easier to read
    'Twinside/vim-haskellConceal',

    -- Only load for Haskell files to avoid affecting other languages
    ft = 'haskell',

    -- Configuration to automatically enable concealing for Haskell files
    config = function()
      -- Set up autocommand to enable concealing when opening Haskell files
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'haskell',
        callback = function()
          -- Enable concealing (level 2 shows concealed text with replacement)
          vim.opt_local.conceallevel = 2

          -- Set conceal cursor to not show concealed text when cursor is on the line
          -- 'n' = normal mode, 'i' = insert mode, 'c' = command mode, 'v' = visual mode
          vim.opt_local.concealcursor = 'nc'

          -- Notify that concealing is enabled
        end,
      })

      -- Set up keymaps to toggle concealing easily
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'haskell',
        callback = function()
          local opts = { noremap = true, silent = true, buffer = true }

          -- Toggle concealing on/off
          vim.keymap.set('n', '<leader>tc', function()
            if vim.o.conceallevel == 0 then
              vim.opt_local.conceallevel = 2
              vim.notify('Haskell concealing enabled', vim.log.levels.INFO)
            else
              vim.opt_local.conceallevel = 0
              vim.notify('Haskell concealing disabled', vim.log.levels.INFO)
            end
          end, vim.tbl_extend('force', opts, { desc = 'Toggle Haskell concealing' }))
        end,
      })
    end,

    -- Note: Concealing transforms operators for display only - your actual code remains unchanged
    -- Common transformations:
    -- -> becomes →    (right arrow)
    -- <- becomes ←    (left arrow)
    -- => becomes ⇒    (double right arrow)
    -- :: becomes ∷    (proportion)
    -- forall becomes ∀ (for all quantifier)
    -- lambda becomes λ (lambda symbol)
    -- You can toggle with <leader>tc or :set conceallevel=0/2
  },

  { -- Enhanced Haskell syntax highlighting and indentation
    -- Provides much better syntax highlighting than Neovim's built-in Haskell support
    -- Recognizes modern Haskell language extensions and features
    'neovimhaskell/haskell-vim',

    -- Only load for Haskell files
    ft = 'haskell',

    -- Enable support for various Haskell language extensions
    -- These improve syntax highlighting for advanced Haskell features
    init = function()
      -- Quantified constraints (forall a. ...)
      vim.g.haskell_enable_quantification = 1

      -- Recursive do-notation (mdo syntax)
      vim.g.haskell_enable_recursivedo = 1

      -- Arrow syntax for programming with arrows
      vim.g.haskell_enable_arrowsyntax = 1

      -- Pattern synonyms (allows custom pattern matching)
      vim.g.haskell_enable_pattern_synonyms = 1

      -- Type roles for type safety
      vim.g.haskell_enable_typeroles = 1

      -- Static pointers for distributed programming
      vim.g.haskell_enable_static_pointers = 1

      -- Backpack module system support
      vim.g.haskell_backpack = 1
    end,
  },

  { -- Complete Haskell development environment with automatic toolchain management
    -- This is the main plugin for Haskell development - it provides LSP integration,
    -- REPL support, debugging, and many other professional development features
    -- Enhanced to automatically handle different GHC versions per project
    'mrcjkb/haskell-tools.nvim',

    -- Use version 3.x for stability
    version = '^3',

    -- Load for all Haskell-related file types
    ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },

    dependencies = {
      -- Required for various utility functions
      'nvim-lua/plenary.nvim',
    },

    -- Configuration options for haskell-tools.nvim
    -- This plugin uses opts instead of a setup function
    opts = {
      -- HLS (Haskell Language Server) configuration
      hls = {
        -- Default settings for HLS - can be overridden per project
        default_settings = {
          haskell = {
            -- Formatting settings
            formattingProvider = 'stylish-haskell', -- or 'fourmolu', 'stylish-haskell', 'brittany'

            -- Enable/disable various HLS features
            checkProject = true, -- Check the entire project, not just open files
            maxCompletions = 40, -- Limit number of completions

            -- Plugin settings
            plugin = {
              -- Enable specific HLS plugins
              ['ghcide-completions'] = { enabled = true },
              ['ghcide-hover-and-symbols'] = { enabled = true },
              ['ghcide-type-lenses'] = { enabled = true },

              -- Import management
              importLens = { enabled = true },
              moduleName = { enabled = true },

              -- Code actions
              refineImports = { enabled = true },
              retrie = { enabled = true },

              -- Formatting
              -- ormolu = { enabled = true },
              -- fourmolu = { enabled = true },
              stylishHaskell = { enabled = true }, -- Disable if using ormolu/fourmolu

              -- Evaluation
              eval = { enabled = true },

              -- Class and instance suggestions
              class = { enabled = true },
              pragmas = { enabled = true },

              -- Hlint integration
              hlint = { enabled = true },
            },
          },
        },
      },

      -- Tools configuration for automatic installation and management
      tools = {
        -- REPL configuration
        repl = {
          -- Auto-detect whether to use Stack, Cabal, or plain GHCi
          -- Stack and Cabal will use the project-specific GHC version
          auto_focus = true, -- Automatically focus REPL window when opened
          builtin = true, -- Use Neovim's built-in terminal for REPL
        },

        -- Hover configuration
        hover = {
          -- Enable automatic hover when cursor stops
          auto = false,
          -- Show border around hover window
          border = 'rounded',
        },

        -- Definition preview configuration
        definition = {
          -- Enable automatic preview when navigating to definitions
          auto = false,
        },
      },

      -- DAP (Debug Adapter Protocol) configuration for Haskell debugging
      dap = {
        -- Automatically set up debugging for Haskell
        auto_setup = true,
      },
    },

    -- Enhanced configuration with automatic GHC version detection and toolchain management
    -- Note: haskell-tools.nvim automatically configures itself, so we set up keymaps and autocommands
    config = function()
      local ht = require 'haskell-tools'

      -- Set up autocommand for Haskell-specific keymaps and project detection
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
        callback = function(event)
          local bufnr = event.buf
          local opts = { noremap = true, silent = true, buffer = bufnr }

          -- Check for Stack or Cabal configuration files to determine project type
          local cwd = vim.fn.getcwd()

          -- Look for stack.yaml (Stack project)
          if vim.fn.filereadable(cwd .. '/stack.yaml') == 1 then
            vim.notify('Detected Stack project - using Stack resolver GHC version', vim.log.levels.INFO)
            -- Stack automatically handles GHC versions based on the resolver

            -- Look for cabal.project or *.cabal files (Cabal project)
          elseif vim.fn.filereadable(cwd .. '/cabal.project') == 1 or #vim.fn.glob(cwd .. '/*.cabal', false, true) > 0 then
            vim.notify('Detected Cabal project - using project GHC version', vim.log.levels.INFO)
            -- Cabal projects should use GHCup to manage GHC versions
          else
            -- Standalone Haskell file
            vim.notify('Standalone Haskell file - using system GHC', vim.log.levels.INFO)
          end

          -- NOTE: haskell-language-server (HLS) relies heavily on code lenses
          -- Code lenses provide contextual actions like "Add type signature", "Import module", etc.
          -- Auto-refresh is enabled by default to keep these up-to-date

          -- Set up Haskell-specific keymaps

          -- Run code lens action under cursor
          -- Code lenses show contextual actions like type signatures, imports, etc.
          vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, opts)

          -- Hoogle search for the type signature under cursor
          -- Hoogle is Haskell's search engine - searches by type signatures and names
          -- This is incredibly useful for discovering functions or understanding types
          vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)

          -- Evaluate all code snippets in the current buffer
          -- Uses GHCi to evaluate Haskell expressions and show results inline
          -- Great for testing small pieces of code without leaving the editor
          vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)

          -- Toggle GHCi REPL for the current package
          -- GHCi (Glasgow Haskell Compiler Interactive) is Haskell's REPL
          -- This loads your entire project so you can test functions interactively
          vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)

          -- Toggle GHCi REPL for just the current buffer
          -- Useful when you want to test just the current module
          vim.keymap.set('n', '<leader>rf', function()
            ht.repl.toggle(vim.api.nvim_buf_get_name(0))
          end, opts)

          -- Quit the REPL
          -- Clean way to close the interactive session
          vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)

          -- Additional useful Haskell keymaps

          -- Show type signature under cursor
          vim.keymap.set('n', '<space>ht', function()
            vim.lsp.buf.hover()
          end, opts)

          -- Go to definition (works with Haskell imports and local definitions)
          vim.keymap.set('n', '<space>gd', function()
            vim.lsp.buf.definition()
          end, opts)

          -- Find references (useful for refactoring)
          vim.keymap.set('n', '<space>gr', function()
            vim.lsp.buf.references()
          end, opts)

          -- Rename symbol (safe refactoring across the project)
          vim.keymap.set('n', '<space>rn', function()
            vim.lsp.buf.rename()
          end, opts)

          -- Format the current buffer with the configured formatter (ormolu/fourmolu)
          vim.keymap.set('n', '<space>hf', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })

      -- Helper function to check and install required tools
      local function ensure_haskell_tools()
        local tools_to_check = {
          'ghc', -- Glasgow Haskell Compiler
          'cabal', -- Cabal build tool
          'stack', -- Stack build tool (optional)
          'haskell-language-server', -- Language server
          'ormolu', -- Code formatter
          'hlint', -- Linter
        }

        for _, tool in ipairs(tools_to_check) do
          if vim.fn.executable(tool) == 0 then
            vim.notify('Missing Haskell tool: ' .. tool .. '. Consider installing via GHCup or your package manager.', vim.log.levels.WARN)
          end
        end
      end

      -- Check for required tools when Haskell files are opened
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'haskell',
        callback = ensure_haskell_tools,
        once = true, -- Only check once per session
      })
    end,
  },

  -- Additional useful plugins for development
  {
    'windwp/nvim-ts-autotag',
    event = 'VeryLazy',
    opts = {},
  },

  -- Better quickfix window
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    opts = {},
  },

  -- Color highlighter
  {
    'norcalli/nvim-colorizer.lua',
    event = 'VeryLazy',
    config = function()
      require('colorizer').setup()
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
    },
    config = function(_, opts)
      require('notify').setup(opts)
      vim.notify = require 'notify'
    end,
  },

  -- Zen mode for distraction-free coding
  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    keys = { { '<leader>z', '<cmd>ZenMode<cr>', desc = 'Zen Mode' } },
    opts = {
      window = {
        width = 90,
        options = {
          signcolumn = 'no',
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = '0',
          list = false,
        },
      },
    },
  },

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
      'stevearc/dressing.nvim', -- Clean input dialogs
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
        vim.keymap.set({ 'n', 'v', 'i' }, '<C-;>', '<cmd>AvanteAsk<cr>', vim.tbl_extend('force', opts, { desc = '⚡ Quick AI Chat' }))

        -- AI code editing (like Cursor's inline AI)
        vim.keymap.set({ 'n', 'v' }, '<leader>ae', '<cmd>AvanteEdit<cr>', vim.tbl_extend('force', opts, { desc = '✨ AI Edit Code' }))
      end)
    end,

    -- Simple build step
    build = vim.fn.has 'win32' ~= 0 and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false' or 'make',
  },

  { -- Alternative colorscheme with multiple variants
    -- Catppuccin is a beautiful, warm colorscheme with excellent plugin integration
    -- It comes in 4 flavors: Latte (light), Frappe, Macchiato, and Mocha (dark)
    'catppuccin/nvim',
    name = 'catppuccin',

    -- High priority ensures it loads early for consistent theming
    priority = 1000,

    opts = {
      -- Choose the flavor/variant of Catppuccin
      flavour = 'mocha', -- Options: latte, frappe, macchiato, mocha

      -- Automatic light/dark mode switching based on system preference
      background = { light = 'latte', dark = 'mocha' },

      -- Visual appearance settings
      transparent_background = false, -- Set to true for terminal transparency
      show_end_of_buffer = false, -- Hide tildes at end of file
      term_colors = false, -- Don't set terminal colors
      dim_inactive = { enabled = false }, -- Don't dim inactive windows

      -- Typography settings - customize to your preference
      no_italic = false, -- Allow italic text
      no_bold = false, -- Allow bold text
      no_underline = false, -- Allow underlined text

      -- Syntax highlighting styles for different code elements
      styles = {
        comments = { 'italic' }, -- Make comments italic
        conditionals = { 'italic' }, -- Make if/else/etc italic
        loops = {}, -- Default style for loops
        functions = {}, -- Default style for functions
        keywords = { 'italic' }, -- Default style for keywords
        strings = {}, -- Default style for strings
        variables = {}, -- Default style for variables
        numbers = {}, -- Default style for numbers
        booleans = {}, -- Default style for true/false
        properties = {}, -- Default style for object properties
        types = { 'italic' }, -- Default style for type annotations
        operators = {}, -- Default style for +, -, etc.
      },

      -- Integration with other plugins for consistent theming
      integrations = {
        cmp = true, -- Completion menu theming
        gitsigns = true, -- Git signs in gutter
        nvimtree = true, -- File explorer theming
        treesitter = true, -- Syntax highlighting
        notify = false, -- Notification theming
        mini = { enabled = true }, -- Mini.nvim plugins
        telescope = { enabled = true }, -- Fuzzy finder theming
        which_key = true, -- Keymap helper theming
      },
    },
  },

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  --    {
  --        'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
  --
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`.
  --
  -- See `:help gitsigns` to understand what the configuration keys do
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

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

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
        { '<leader>r', group = '[R]epl/[R]eplace' }, -- REPL and replace operations
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
        { '<leader>;', desc = '📜 Command History' }, -- Command history
        { '<leader>:', desc = '🔍 Search History' }, -- Search history
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

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

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- Find references for the word under your cursor.
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>ti', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --

        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },

        -- Haskell Language Server (configured via haskell-tools.nvim)
        -- Note: haskell-tools.nvim automatically configures haskell-language-server
        -- so we don't need to add it here, but we could add other servers if needed

        -- Additional language servers you might want to add:
        bashls = {}, -- Bash LSP
        cssls = {}, -- CSS LSP
        html = {}, -- HTML LSP
        jsonls = {}, -- JSON LSP
        yamlls = {}, -- YAML LSP
        marksman = {}, -- Markdown LSP
        ts_ls = {}, -- TypeScript/JavaScript LSP
        eslint = {}, -- ESLint LSP
        pyright = {}, -- Python LSP
        rust_analyzer = {}, -- Rust LSP
        -- clangd = {},        -- C/C++ LSP
        -- gopls = {},         -- Go LSP
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        -- Haskell tools (haskell-language-server is installed via haskell-tools.nvim)
        -- 'fourmolu', -- Haskell formatter
        -- 'ormolu', -- Alternative Haskell formatter
        'hlint', -- Haskell linter
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Haskell formatters
        haskell = { 'stylish-haskell', stop_after_first = true },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default',

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },

  -- Highlight todo, notes, etc in comments
  -- { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- { -- Collection of various small independent plugins/modules
  --   'echasnovski/mini.nvim',
  --   config = function()
  --     -- Better Around/Inside textobjects
  --     --
  --     -- Examples:
  --     --  - va)  - [V]isually select [A]round [)]paren
  --     --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
  --     --  - ci'  - [C]hange [I]nside [']quote
  --     require('mini.ai').setup { n_lines = 500 }

  --     -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --     --
  --     -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  --     -- - sd'   - [S]urround [D]elete [']quotes
  --     -- - sr)'  - [S]urround [R]eplace [)] [']
  --     require('mini.surround').setup()

  --     -- Simple and easy statusline.
  --     --  You could remove this setup call if you don't like it,
  --     --  and try some other statusline plugin
  --     local statusline = require 'mini.statusline'
  --     -- set use_icons to true if you have a Nerd Font
  --     statusline.setup { use_icons = vim.g.have_nerd_font }

  --     -- You can configure sections in the statusline by overriding their
  --     -- default behavior. For example, here we set the section for
  --     -- cursor location to LINE:COLUMN
  --     ---@diagnostic disable-next-line: duplicate-set-field
  --     statusline.section_location = function()
  --       return '%2l:%-2v'
  --     end

  --     -- ... and there is more!
  --     --  Check out: https://github.com/echasnovski/mini.nvim
  --   end,
  -- },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'haskell',
        'json',
        'yaml',
        'toml',
        'css',
        'javascript',
        'typescript',
        'python',
        'rust',
        'go',
        'dockerfile',
        'gitignore',
        'sql',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {},
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
