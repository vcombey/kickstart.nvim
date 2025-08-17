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
      vim.g.hscoptions = '' -- Use default settings, or customize as needed

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
            else
              vim.opt_local.conceallevel = 0
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
      vim.g.haskell_classic_highlighting = 1 -- Better classic syntax
      vim.g.haskell_indent_if = 3 -- Better if/then/else indentation
      vim.g.haskell_indent_case = 2 -- Better case expression indentation
      vim.g.haskell_indent_let = 4 -- Better let/in indentation
      vim.g.haskell_indent_where = 6 -- Better where clause indentation
      vim.g.haskell_indent_before_where = 2 -- Space before where
      vim.g.haskell_indent_after_bare_where = 2 -- Space after bare where
      vim.g.haskell_indent_do = 3 -- Better do notation indentation
      vim.g.haskell_indent_guard = 2 -- Better guard indentation
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
    opts = function()
      return {
        -- HLS (Haskell Language Server) configuration
        hls = {
          -- Force the correct HLS binary and environment
          cmd = {
            'env',
            'PATH=' .. vim.fn.expand('~/.ghcup/bin') .. ':' .. (vim.env.PATH or ''),
            vim.fn.expand('~/.ghcup/bin/haskell-language-server'),
            '--lsp'
          },

          -- Default settings for HLS - can be overridden per project
          default_settings = {
            haskell = {
            -- Formatting settings - Use ormolu as primary formatter
            formattingProvider = 'ormolu',

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

              -- Formatting - ONLY enable ormolu to avoid conflicts
              ormolu = { enabled = true },
              fourmolu = { enabled = false },
              stylishHaskell = { enabled = false },

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
    }
    end,

        -- Enhanced configuration with automatic GHC version detection and toolchain management
    -- Note: haskell-tools.nvim automatically configures itself, so we set up keymaps and autocommands
    config = function()
            -- CRITICAL: Force correct environment for HLS before any initialization
      -- Set up environment variables that HLS will inherit
      local ghcup_path = vim.fn.expand('~/.ghcup/bin')
      local current_path = vim.env.PATH or ''

      -- Ensure ghcup is at the front of PATH
      if not current_path:find(ghcup_path, 1, true) then
        vim.env.PATH = ghcup_path .. ':' .. current_path
      end

      -- Force GHC environment variables
      vim.env.GHC_VERSION = '9.6.7'

      -- BACKUP: Also configure lspconfig directly in case haskell-tools doesn't use our command
      local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
      if lspconfig_ok then
        lspconfig.hls.setup {
          cmd = {
            'env',
            'PATH=' .. ghcup_path .. ':' .. current_path,
            ghcup_path .. '/haskell-language-server',
            '--lsp'
          },
          on_attach = function(client, bufnr)
            -- Only show this message once to verify it's working
            if not vim.g.hls_correct_version_notified then
              vim.notify('✓ HLS started with correct GHC environment', vim.log.levels.INFO)
              vim.g.hls_correct_version_notified = true
            end
          end,
        }
      end

      local ht = require 'haskell-tools'

      -- Set up autocommand for Haskell-specific keymaps and project detection
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
        callback = function(event)
          local bufnr = event.buf
          local opts = { noremap = true, silent = true, buffer = bufnr }

          -- Enhanced project detection with better debugging
          local function find_project_root(path)
            path = path or vim.fn.expand '%:p:h' -- Start from current file's directory

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
            -- Change working directory to project root if needed
            if vim.fn.getcwd() ~= project_root then
              vim.cmd('cd ' .. project_root)
            end
          elseif project_type == 'cabal' then
            -- Change working directory to project root if needed
            if vim.fn.getcwd() ~= project_root then
              vim.cmd('cd ' .. project_root)
            end
          else
            -- Enhanced standalone detection with more info
            local cwd = vim.fn.getcwd()
            local file_dir = vim.fn.expand '%:p:h'
            vim.notify(
              '⚠ Standalone Haskell file detected\n'
                .. 'Current working dir: '
                .. cwd
                .. '\n'
                .. 'File directory: '
                .. file_dir
                .. '\n'
                .. 'No stack.yaml or cabal.project found',
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

                    -- Diagnostic command to check Haskell environment
          vim.keymap.set('n', '<space>hd', function()
            local diagnostics = {}

            -- Check PATH
            local path_entries = vim.split(vim.env.PATH or '', ':')
            local ghcup_in_path = false
            for _, entry in ipairs(path_entries) do
              if entry:find('ghcup') then
                ghcup_in_path = true
                break
              end
            end
            table.insert(diagnostics, 'GHCup in PATH: ' .. (ghcup_in_path and '✓' or '✗'))

            -- Check GHC version
            local ghc_output = vim.fn.system('ghc --version'):gsub('\n', '')
            local ghc_version = ghc_output:match('version ([0-9]+%.[0-9]+%.[0-9]+)')
            local version_status = ghc_version == '9.6.7' and '✓' or '⚠'
            table.insert(diagnostics, 'GHC Version: ' .. (ghc_version or 'Unknown') .. ' ' .. version_status)

            -- Check HLS binary location
            local hls_which = vim.fn.system('which haskell-language-server'):gsub('\n', '')
            table.insert(diagnostics, 'HLS Binary: ' .. hls_which)

            -- Check LSP clients attached
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            local hls_clients = {}
            for _, client in ipairs(clients) do
              if client.name:find('haskell') or client.name:find('hls') then
                table.insert(hls_clients, client.name .. ' (pid: ' .. (client.get_process_id and client.get_process_id() or 'unknown') .. ')')
              end
            end
            table.insert(diagnostics, 'LSP Clients: ' .. (next(hls_clients) and table.concat(hls_clients, ', ') or 'None'))

            -- Show results
            vim.notify(table.concat(diagnostics, '\n'), vim.log.levels.INFO)
          end, vim.tbl_extend('force', opts, { desc = 'Haskell diagnostics' }))

          -- Force restart HLS with correct environment
          vim.keymap.set('n', '<space>hr', function()
            -- Stop all Haskell LSP clients
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            for _, client in ipairs(clients) do
              if client.name:find('haskell') or client.name:find('hls') then
                client.stop()
                vim.notify('Stopped ' .. client.name, vim.log.levels.INFO)
              end
            end

            -- Force correct PATH
            local ghcup_path = vim.fn.expand('~/.ghcup/bin')
            vim.env.PATH = ghcup_path .. ':' .. (vim.env.PATH or '')

            -- Restart LSP after a short delay
            vim.defer_fn(function()
              vim.cmd('LspRestart')
              vim.notify('Restarting HLS with correct GHC environment...', vim.log.levels.INFO)
            end, 1000)
          end, vim.tbl_extend('force', opts, { desc = 'Restart HLS with correct environment' }))
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

