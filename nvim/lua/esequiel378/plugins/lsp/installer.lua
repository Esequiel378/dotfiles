local M = {}

local servers = {
  gopls = {},
  golangci_lint_ls = {
    default_config = {
      cmd = { "golangci-lint-langserver" },
      root_dir = function()
        return vim.loop.cwd()
      end,
      init_options = {
        command = {
          "golangci-lint",
          "run",
          "--enable-all",
          "--disable",
          "--allow-parallel-runners",
          "lll",
          "--out-format",
          "json",
        },
      },
    },
  },
  html = {},
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    },
  },
  pyright = {
    analysis = {
      typeCheckingMode = "off",
    },
  },
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          maxPreload = 2000,
          preloadFileSize = 5000,
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          },
        },
      },
    },
  },
  tsserver = {
    disable_formatting = true,
    debug = false,
  },
  vimls = {},
  yamlls = {
    schemastore = {
      enable = true,
    },
    settings = {
      yaml = {
        hover = true,
        completion = true,
        validate = true,
        schemas = require("schemastore").json.schemas(),
      },
    },
  },
  dockerls = {},
  bashls = {},
  omnisharp = {},
  emmet_ls = {},
  marksman = {},
}

M.default_config = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  --capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities) -- for nvim-cmp

  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return {
    on_attach = function(client, bufnr)
      -- Enable completion triggered by <C-X><C-O>
      -- See `:help omnifunc` and `:help ins-completion` for more information.
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

      -- Use LSP as the handler for formatexpr.
      -- See `:help formatexpr` for more information.
      vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

      -- Configure key mappings
      require("esequiel378.plugins.lsp.keymaps").config(client, bufnr)

      -- Configure formatting
      -- require("config.lsp.null-ls.formatters").setup(client, bufnr)

      -- tagfunc
      if client.server_capabilities.definitionProvider then
        vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
      end

      -- nvim-navic
      if client.server_capabilities.documentSymbolProvider then
        local navic = require "nvim-navic"
        navic.attach(client, bufnr)
      end
    end,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 50,
    },
  }
end

M.config = function()
  require("mason").setup {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  }

  require("mason-lspconfig").setup {
    ensure_installed = { "sumneko_lua" },
  }

  require("mason-tool-installer").setup {
    ensure_installed = { "stylua", "shfmt", "shellcheck", "black", "isort", "prettierd" },
    auto_update = false,
    run_on_start = true,
  }

  local lspconfig = require "lspconfig"
  local options = M.default_config()

  require("mason-lspconfig").setup_handlers {
    function(server_name)
      local opts = vim.tbl_deep_extend("force", options, servers[server_name] or {})
      lspconfig[server_name].setup(opts)
    end,
    ["sumneko_lua"] = function()
      local opts = vim.tbl_deep_extend("force", options, servers["sumneko_lua"] or {})
      lspconfig.sumneko_lua.setup(require("lua-dev").setup { lspconfig = opts })
    end,
    ["tsserver"] = function()
      local opts = vim.tbl_deep_extend("force", options, servers["tsserver"] or {})
      require("typescript").setup {
        server = opts,
      }
    end,
  }

  require("esequiel378.plugins.lsp.null-ls.init").setup(options)
end

return M
