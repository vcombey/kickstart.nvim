-- Editor enhancement plugins for better text editing experience
return {
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

  -- Todo comments
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
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
}