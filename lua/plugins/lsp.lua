local function on_attach(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


  -- Buffer local mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local opts = { buffer = bufnr, noremap = true, silent = true }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "sd", vim.diagnostic.open_float)

  vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format { async = true }
  end, opts)
end

return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
    requires = { "niuiic/format.nvim" },
    build = ":MasonUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function(_, _)
      require("mason").setup {
        -- TODO: Make sure to install this dependencies
        ensure_installed = {
          "black",
          "css-lsp",
          "delve",
          "djlint",
          "docker-compose-language-service",
          "dockerfile-language-server",
          "editorconfig-checker",
          "eslint-lsp",
          "fixjson",
          "gofumpt",
          "goimports",
          "goimports-reviser",
          "golangci-lint-langserver",
          "golines",
          "gomodifytags",
          "gopls",
          "gotests",
          "impl",
          "grammarly-languageserver",
          "htmx-lsp",
          "json-lsp",
          "misspell",
          "prettierd",
          "selene",
          "shellcheck",
          "shfmt",
          "stylua",
          "svelte-language-server",
          "tailwindcss-language-server",
          "templ",
          "typescript-language-server",
          "yaml-language-server",
          "yamlfmt",
        }
      }

      require("mason-lspconfig").setup {
        automatic_installation = true,
        ensure_installed = {
          "bashls",
          "cssls",
          "dockerls",
          "docker_compose_language_service",
          "eslint",
          "golangci_lint_ls",
          "gopls",
          "jsonls",
          "tsserver",
          "lua_ls",
          "svelte",
          "tailwindcss",
          "yamlls",
        },
      }

      require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name)
          require("lspconfig")[server_name].setup {
            on_attach = on_attach
          }
        end,
        ["lua_ls"] = function()
          require 'lspconfig'.lua_ls.setup {
            on_attach = on_attach,
            on_init = function(client)
              local path = client.workspace_folders[1].name

              if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                return true
              end

              client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                Lua = {
                  runtime = {
                    -- Tell the language server which version of Lua you're using
                    -- (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT'
                  },
                  -- Make the server aware of Neovim runtime files
                  workspace = {
                    checkThirdParty = false,
                    library = {
                      vim.env.VIMRUNTIME
                      -- "${3rd}/luv/library"
                      -- "${3rd}/busted/library",
                    }
                    -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                    -- library = vim.api.nvim_get_runtime_file("", true)
                  }
                }
              })

              client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
            end,
          }
        end,

        ["eslint"] = function()
          require('lspconfig').eslint.setup({
            on_attach = function(client, bufnr)
              on_attach(client, bufnr)
              vim.api.nvim_del_user_command('EslintFixAll')
            end
          })
        end

        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        -- ["rust_analyzer"] = function ()
        --     require("rust-tools").setup {}
        -- end
      }
    end,
  }
}
