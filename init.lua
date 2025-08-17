-- Set <space> as the leader key
-- See `:help mapleader`
--
vim.keymap.set('n', '<leader>k', function()
  dofile(vim.env.MYVIMRC)
end)
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Ensure PATH includes development tools ]]
-- Add GHCup and other development tool paths to Neovim's PATH
-- This ensures LSP servers and tools can be found by plugins
local function ensure_path()
  local paths_to_add = {
    vim.fn.expand '~/.ghcup/bin', -- GHCup Haskell tools (MUST be first!)
    vim.fn.expand '~/.cabal/bin', -- Cabal-installed tools
    vim.fn.expand '~/.local/bin', -- Local user binaries
    '/usr/local/bin', -- Homebrew tools on macOS
    '/opt/homebrew/bin', -- Homebrew tools on Apple Silicon
  }

  local current_path = vim.env.PATH or ''

  -- CRITICAL: First, try to get full environment from shell including ghcup settings
  local shell = vim.env.SHELL or '/bin/zsh'

  -- Source the shell profile to get ghcup environment
  local shell_commands = {
    shell .. ' -l -c "echo $PATH"', -- Login shell to source profiles
    shell .. ' -c "source ~/.ghcup/env && echo $PATH"', -- Explicit ghcup sourcing
  }

  local shell_path = nil
  for _, cmd in ipairs(shell_commands) do
    local success, shell_output = pcall(function()
      return vim.fn.system(cmd):gsub('\n', '')
    end)

    if success and shell_output and shell_output ~= '' and shell_output:find('ghcup') then
      shell_path = shell_output
      vim.env.PATH = shell_path
      current_path = shell_path
      -- vim.notify('✓ Inherited ghcup PATH from: ' .. cmd, vim.log.levels.DEBUG)
      break
    end
  end

  -- Ensure our specific paths are included (ghcup first for priority)
  for _, path in ipairs(paths_to_add) do
    if vim.fn.isdirectory(path) == 1 then
      -- Force add path at the beginning if it's ghcup, otherwise at the end
      if path:find('ghcup') then
        if not current_path:find(path, 1, true) then
          vim.env.PATH = path .. ':' .. current_path
          current_path = vim.env.PATH
        end
      else
        if not current_path:find(path, 1, true) then
          vim.env.PATH = current_path .. ':' .. path
          current_path = vim.env.PATH
        end
      end
    end
  end

  -- Critical: Verify we're using the correct GHC version for HLS compatibility
  local ghc_version_check = pcall(function()
    local ghc_output = vim.fn.system('ghc --version'):gsub('\n', '')
    local version = ghc_output:match('version ([0-9]+%.[0-9]+%.[0-9]+)')

    if version then
      if version == '9.6.7' then
        -- vim.notify('✓ Using GHC ' .. version .. ' (compatible with HLS)', vim.log.levels.DEBUG)
      elseif version == '9.10.2' then
        vim.notify('⚠ Warning: Using GHC ' .. version .. ' but HLS was compiled with 9.6.7\n' ..
                   'Run: ghcup set ghc 9.6.7', vim.log.levels.WARN)
      else
        vim.notify('ℹ Using GHC ' .. version, vim.log.levels.INFO)
      end
    end
  end)

  -- Debug: verify important tools are available after PATH setup
  local important_tools = { 'haskell-language-server', 'ghc', 'cabal', 'ormolu' }
  local missing_tools = {}
  for _, tool in ipairs(important_tools) do
    if vim.fn.executable(tool) == 0 then
      table.insert(missing_tools, tool)
    end
  end

  if #missing_tools > 0 then
    vim.notify('Missing Haskell tools: ' .. table.concat(missing_tools, ', ') ..
               '\nConsider installing via: curl --proto "=https" --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh',
               vim.log.levels.WARN)
  end
end

-- Call this early to setup PATH
ensure_path()

-- Enhanced backup: Ensure PATH is set when entering Haskell files
-- This is critical for GUI Neovim instances that don't inherit shell environment
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
  callback = function()
    ensure_path()
    -- Small delay to ensure LSP picks up the new PATH
    vim.defer_fn(function()
      -- Force LSP restart if needed
      if vim.bo.filetype == 'haskell' then
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients == 0 then
          vim.notify('Restarting Haskell LSP with updated PATH...', vim.log.levels.INFO)
          vim.defer_fn(function()
            vim.cmd('LspRestart')
          end, 100)
        end
      end
    end, 50)
  end,
  group = vim.api.nvim_create_augroup('haskell-path-setup', { clear = true }),
})

-- [[ Set API Keys Early ]]
-- Load Anthropic API key for AI features (needs to be early for plugins like Avante)
local config_path = vim.fn.stdpath 'config'
local api_key_file = config_path .. '/anthropic_key.lua'

local ok, api_key = pcall(function()
  return dofile(api_key_file)
end)

vim.env.AVANTE_ANTHROPIC_API_KEY = api_key

-- Load OpenAI API key from dotfile if present
local openai_key_file = config_path .. '/openai_key.lua'
local ok_openai, openai_key = pcall(function()
  return dofile(openai_key_file)
end)
if ok_openai and type(openai_key) == 'string' and openai_key ~= '' then
  vim.env.AVANTE_OPENAI_API_KEY = openai_key
end

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Enable syntax highlighting (required for concealing and many other features)
vim.cmd.syntax 'enable'

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

-- guicursor configures cursor appearance and behavior
-- Setting blinkon to 0 disables cursor blinking in all modes
-- This provides a steady, non-distracting cursor in terminal mode
-- See `:help 'guicursor'`
vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkon0'

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

-- Normal/visual: use window commands directly
vim.keymap.set({'n', 'v'}, '<C-x>h', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set({'n', 'v'}, '<C-x>l', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set({'n', 'v'}, '<C-x>j', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set({'n', 'v'}, '<C-x>k', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Insert: leave insert, then move
vim.keymap.set('i', '<C-x>h', '<Esc><C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('i', '<C-x>l', '<Esc><C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('i', '<C-x>j', '<Esc><C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('i', '<C-x>k', '<Esc><C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Terminal: leave terminal-mode, then move
vim.keymap.set('t', '<C-x>h', [[<C-\><C-n><C-w><C-h>]], { desc = 'Move focus to the left window' })
vim.keymap.set('t', '<C-x>l', [[<C-\><C-n><C-w><C-l>]], { desc = 'Move focus to the right window' })
vim.keymap.set('t', '<C-x>j', [[<C-\><C-n><C-w><C-j>]], { desc = 'Move focus to the lower window' })
vim.keymap.set('t', '<C-x>k', [[<C-\><C-n><C-w><C-k>]], { desc = 'Move focus to the upper window' })

vim.keymap.set({'n'}, '<enter>', 'i', { desc = 'go to insert mode' })

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

-- Toggle zoom of current window (tmux-like)
-- Uses a dedicated tab to "zoom" and closes it to restore the previous layout
local function toggle_zoom_current_window()
  if vim.t._is_zoomed then
    vim.cmd('tabclose')
  else
    vim.cmd('tab split')
    vim.t._is_zoomed = true
  end
end

vim.api.nvim_create_user_command('ToggleZoom', toggle_zoom_current_window, {})

-- Normal/visual: call directly
vim.keymap.set({ 'n', 'v' }, '<C-x>z', toggle_zoom_current_window, { desc = 'Toggle window zoom' })
-- Insert: leave insert, then toggle
vim.keymap.set('i', '<C-x>z', '<Esc>:ToggleZoom<CR>', { desc = 'Toggle window zoom' })
-- Terminal: leave terminal-mode, then toggle
vim.keymap.set('t', '<C-x>z', [[<C-\><C-n>:ToggleZoom<CR>]], { desc = 'Toggle window zoom' })

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

-- Close buffer with Cmd+W (macOS style)
-- Works in normal, insert, and visual modes for convenience
vim.keymap.set({ 'n', 'i', 'v' }, '<D-w>', '<cmd>bdelete<CR>', { desc = 'Close buffer (Cmd+W)' })

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

-- Cmd+V paste functionality (macOS style)
-- Works in normal, insert, visual, and terminal modes
-- Uses the system clipboard register (+) for consistent pasting
vim.keymap.set({ 'n', 'i', 'v' }, '<D-v>', '<esc>"+p', { desc = 'Paste from clipboard (Cmd+V)' })
vim.keymap.set('t', '<D-v>', '<C-\\><C-n>"+pi', { desc = 'Paste from clipboard in terminal (Cmd+V)' })

-- Cmd+C copy functionality (macOS style)
-- Copies to system clipboard register (+)
vim.keymap.set({ 'v' }, '<D-c>', '"+y', { desc = 'Copy to clipboard (Cmd+C)' })


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
vim.keymap.set({ 'n', 'i', 't' }, '<C-j>', '<cmd>ToggleTerm direction=horizontal<cr>', { desc = 'Lazy' })
vim.keymap.set({ 'n', 'i', 't' }, '<D-j>', '<cmd>ToggleTerm direction=horizontal<cr>', { desc = 'Lazy' })

-- [[ Neovide Configuration ]]
-- Check if running in Neovide and apply specific settings
if vim.g.neovide then
  -- Disable animations for better performance and less distraction
  vim.g.neovide_fullscreen = true
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_hide_mouse_when_typing = true

  vim.g.neovide_scale_factor = 1.3
  -- Font scaling keymaps (Cmd+ and Cmd-)
  vim.keymap.set({ 'n', 'i', 'v' }, '<D-=>', function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
  end, { desc = 'Increase font size' })

  vim.keymap.set({ 'n', 'i', 'v' }, '<D-->', function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 0.9
  end, { desc = 'Decrease font size' })

  -- Reset font size
  vim.keymap.set({ 'n', 'i', 'v' }, '<D-0>', function()
    vim.g.neovide_scale_factor = 1.0
  end, { desc = 'Reset font size' })
end

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
  -- Automatically detect tabstop and shiftwidth
  'NMAC427/guess-indent.nvim',

  -- Import all custom plugin configurations
  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {},
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
