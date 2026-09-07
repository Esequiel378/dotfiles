return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        dependencies = {
            "saghen/blink.cmp",
            { 'Bilal2453/luvit-meta', lazy = true },
        },
        ft = 'lua',
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
      },
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local builtin = require 'telescope.builtin'

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', builtin.lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gi', builtin.lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>t', builtin.lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
					map("K", function()
						vim.lsp.buf.hover { border = 'rounded' }
					end, "Hover Documentation")
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

      -- ponytail: sqls reuses DBUI's connection list and always talks to the first
      -- entry; re-read only happens at startup. Add nanotee/sqls.nvim if switching
      -- databases mid-session becomes a habit.
      local function dbui_connections()
        local file = io.open(vim.fn.expand '~/.local/share/db_ui/connections.json', 'r')
        if not file then
          return {}
        end
        local ok, conns = pcall(vim.json.decode, file:read '*a')
        file:close()
        if not ok then
          return {}
        end
        local out = {}
        for _, conn in ipairs(conns) do
          -- sqls only accepts URL-form DSNs for postgres; mysql needs its own format
          if conn.url and conn.url:match '^postgres' then
            table.insert(out, { driver = 'postgresql', dataSourceName = conn.url })
          end
        end
        return out
      end

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
        -- tsserver = {
        --   settings = {
        --     completions = { completeFunctionCalls = true },
        --   },
        --   on_attach = function(client)
        --     -- Disable formatting from tsserver
        --     client.server_capabilities.documentFormattingProvider = false
        --   end,
        -- },
        eslint = {
          settings = {
            codeAction = {
              disableRuleComment = { enable = true },
              showDocumentation = { enable = true },
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              staticcheck = true,
            },
          },
        },
        golangci_lint_ls = {
          filetypes = { "go", "gomod" },
        },
        sqls = {
          settings = {
            sqls = { connections = dbui_connections() },
          },
          on_attach = function(client, bufnr)
            vim.api.nvim_buf_create_user_command(bufnr, 'SqlsConn', function(opts)
              -- sqls advertises no executeCommandProvider, so client:exec_cmd refuses
              -- every command; send the raw request instead
              local cmd = opts.args == '' and { command = 'showConnections' }
                -- sqls wants the index as a numeric *string*, not a number
                or { command = 'switchConnections', arguments = { opts.args } }
              client:request('workspace/executeCommand', cmd, function(err, res)
                vim.notify(err and err.message or (type(res) == 'string' and res or vim.inspect(res)))
              end, bufnr)
            end, { nargs = '?', desc = 'sqls: list connections, or switch to index N' })
          end,
        },
      }

      require('mason').setup()

      -- `servers` is keyed by lspconfig name; mason installs by package name
      local to_package = require('mason-lspconfig').get_mappings().lspconfig_to_package
      local ensure_installed = vim.tbl_map(function(name)
        return to_package[name] or name
      end, vim.tbl_keys(servers))
      vim.list_extend(ensure_installed, {
        -- lua
        'stylua',
        -- Python
        "pyright",
        "ruff",
        -- Svelte / React / Typescript
        "svelte-language-server",
        "typescript-language-server",
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        -- Go
        "golangci-lint",
        -- Docker
        "dockerfile-language-server",
        "docker-compose-language-service",
      })
      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed,
      }

      vim.lsp.config('*', { capabilities = capabilities })
      for name, cfg in pairs(servers) do
        vim.lsp.config(name, cfg)
      end

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_enable = true,
      }
    end,
  },
}
