-- Color themes and appearance
return {
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
}