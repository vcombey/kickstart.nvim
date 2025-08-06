-- Color themes and appearance
--
-- 🎨 HOW TO SWITCH THEMES:
-- The active colorscheme is set in the catppuccin plugin config below
-- To switch themes, move the `vim.cmd.colorscheme` line to your preferred theme's config function
--
-- Available themes:
-- - 'catppuccin-macchiato' (currently active)
-- - 'cyberdream'
-- - 'synthwave84'
-- - 'material-palenight'
-- - 'material-deep-ocean'
--
return {
  { -- Modern cyberpunk theme with neon aesthetics
    -- cyberdream.nvim provides a beautiful cyberpunk/synthwave aesthetic
    -- with excellent contrast and readability for long coding sessions
    'scottmckendry/cyberdream.nvim',
    priority = 1000,
    lazy = false,

    opts = {
      -- Make the theme transparent to show terminal background
      transparent = false,

      -- Add borders around floating windows for better definition
      borderless_telescope = false,

      -- Terminal colors match the theme
      terminal_colors = true,
    },

    config = function(_, opts)
      require('cyberdream').setup(opts)
      -- Cyberdream is no longer the active theme
      -- vim.cmd.colorscheme 'cyberdream'
    end,
  },

  { -- Alternative retro synthwave cyberpunk theme
    -- Synthwave84 brings that authentic 80s cyberpunk aesthetic
    'artanikin/vim-synthwave84',
    priority = 999,
    lazy = false,
  },

  { -- Matrix-inspired cyberpunk theme
    -- Material theme with a dark, cyberpunk-inspired palenight variant
    'marko-cerovac/material.nvim',
    priority = 998,
    lazy = false,

    opts = {
      contrast = {
        terminal = false,
        sidebars = true,
        floating_windows = true,
        cursor_line = false,
        non_current_windows = false,
        filetypes = {},
      },

      styles = {
        comments = { italic = true },
        strings = {},
        keywords = { italic = true },
        functions = {},
        variables = {},
        operators = {},
        types = {},
      },

      plugins = {
        'dap',
        'gitsigns',
        'lsp',
        'mini',
        'neo-tree',
        'nvim-cmp',
        'nvim-notify',
        'nvim-web-devicons',
        'telescope',
        'trouble',
        'which-key',
      },

      disable = {
        colored_cursor = false,
        borders = false,
        background = false,
        term_colors = false,
        eob_lines = false,
      },

      high_visibility = {
        lighter = false,
        darker = true,
      },

      lualine_style = 'default',
      async_loading = true,
    },

    config = function(_, opts)
      require('material').setup(opts)
      -- Available variants: material, material-darker, material-lighter,
      -- material-oceanic, material-palenight, material-deep-ocean
      -- vim.g.material_style = 'palenight'  -- Uncomment to use palenight variant
    end,
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
      flavour = 'macchiato', -- Options: latte, frappe, macchiato, mocha

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

    config = function(_, opts)
      require('catppuccin').setup(opts)
      -- Set catppuccin-macchiato as the active colorscheme
      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
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

      -- Cyberdream is set as the active theme in its config above
      -- To switch to tokyonight, move the colorscheme line to this config function
      -- Available variants: 'tokyonight-storm', 'tokyonight-moon', 'tokyonight-day'
    end,
  },
}
