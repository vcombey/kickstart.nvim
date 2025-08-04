-- Haskell development environment and tools
return {
  { -- Unicode symbol concealing for Haskell (Enhanced version with more features)
    -- Replaces Haskell operators with Unicode symbols for better readability
    -- Examples: -> becomes →, <= becomes ≤, forall becomes ∀, :: becomes ∷
    -- This makes Haskell code more mathematical and easier to read
    'enomsg/vim-haskellConcealPlus',

    -- Only load for Haskell files to avoid affecting other languages
    ft = 'haskell',

    -- Configuration to automatically enable concealing for Haskell files
    config = function()
      -- Configure vim-haskellConcealPlus options
      -- Available options: 'q' '℘' '𝐒' '𝐓' '𝐄' '𝐌' 'A' 's' '*' 'x' 'E' 'e' '⇒' '⇔' 'r' 'b' 'f' 'c' 'h' 'C' 'l' '↱' 'w' '-' 'I' 'i' 'R' 'T' 't' 'B' 'Q' 'Z' 'N' 'D' 'C' '1' 'a'
      -- For full documentation see: https://github.com/enomsg/vim-haskellConcealPlus
      vim.g.hscoptions = "" -- Use default settings, or customize as needed

      -- Set up autocommand to enable concealing when opening Haskell files
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'haskell',
        callback = function()
          -- Enable concealing (level 2 shows concealed text with replacement)
          vim.opt_local.conceallevel = 2

          -- Set conceal cursor behavior
          -- 'n' = normal mode, 'c' = command mode
          -- Note: 'i' and 'v' removed to avoid navigation issues
          vim.opt_local.concealcursor = 'nc'

          -- Ensure traditional syntax highlighting is enabled for this buffer
          vim.cmd('syntax enable')

          -- Set syntax highlighting explicitly for better compatibility
          vim.bo.syntax = 'haskell'

          vim.notify('Haskell concealing enabled', vim.log.levels.INFO)
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

      -- Enhanced syntax highlighting features
      vim.g.haskell_classic_highlighting = 1  -- Better classic syntax
      vim.g.haskell_indent_if = 3             -- Better if/then/else indentation
      vim.g.haskell_indent_case = 2           -- Better case expression indentation
      vim.g.haskell_indent_let = 4            -- Better let/in indentation
      vim.g.haskell_indent_where = 6          -- Better where clause indentation
      vim.g.haskell_indent_before_where = 2   -- Space before where
      vim.g.haskell_indent_after_bare_where = 2 -- Space after bare where
      vim.g.haskell_indent_do = 3             -- Better do notation indentation
      vim.g.haskell_indent_guard = 2          -- Better guard indentation
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

              -- Formatting - ONLY stylish-haskell enabled
              ormolu = { enabled = true },
              fourmolu = { enabled = true },
              stylishHaskell = { enabled = true },

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

          -- Enhanced project detection with better debugging
          local function find_project_root(path)
            path = path or vim.fn.expand('%:p:h') -- Start from current file's directory

            -- Walk up the directory tree looking for project files
            while path ~= '/' and path ~= '' do
              -- Check for Stack project
              if vim.fn.filereadable(path .. '/stack.yaml') == 1 then
                return path, 'stack'
              end

              -- Check for Cabal project
              if vim.fn.filereadable(path .. '/cabal.project') == 1 then
                return path, 'cabal'
              end

              -- Check for .cabal files
              local cabal_files = vim.fn.glob(path .. '/*.cabal', false, true)
              if #cabal_files > 0 then
                return path, 'cabal'
              end

              -- Move up one directory
              path = vim.fn.fnamemodify(path, ':h')
            end

            return nil, 'standalone'
          end

          local project_root, project_type = find_project_root()

          if project_type == 'stack' then
            vim.notify('✓ Detected Stack project at: ' .. project_root, vim.log.levels.INFO)
            -- Change working directory to project root if needed
            if vim.fn.getcwd() ~= project_root then
              vim.cmd('cd ' .. project_root)
              vim.notify('Changed working directory to: ' .. project_root, vim.log.levels.INFO)
            end
          elseif project_type == 'cabal' then
            vim.notify('✓ Detected Cabal project at: ' .. project_root, vim.log.levels.INFO)
            -- Change working directory to project root if needed
            if vim.fn.getcwd() ~= project_root then
              vim.cmd('cd ' .. project_root)
              vim.notify('Changed working directory to: ' .. project_root, vim.log.levels.INFO)
            end
          else
            -- Enhanced standalone detection with more info
            local cwd = vim.fn.getcwd()
            local file_dir = vim.fn.expand('%:p:h')
            vim.notify(
              '⚠ Standalone Haskell file detected\n' ..
              'Current working dir: ' .. cwd .. '\n' ..
              'File directory: ' .. file_dir .. '\n' ..
              'No stack.yaml or cabal.project found',
              vim.log.levels.WARN
            )
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
          -- vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)

          -- Toggle GHCi REPL for just the current buffer
          -- Useful when you want to test just the current module
          -- vim.keymap.set('n', '<leader>rf', function()
          --   ht.repl.toggle(vim.api.nvim_buf_get_name(0))
          -- end, opts)

          -- Quit the REPL
          -- Clean way to close the interactive session
          -- vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)

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
}