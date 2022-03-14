local M = {}

function M.setup(use)
  use {
    "neovim/nvim-lspconfig",
    opt = true,
    event = "BufReadPre",
    wants = {
      "nvim-lsp-installer",
      "lua-dev.nvim",
      "vim-illuminate",
      "null-ls.nvim",
      "schemastore.nvim",
    },
    requires = {
      "williamboman/nvim-lsp-installer",
      "folke/lua-dev.nvim",
      "RRethy/vim-illuminate",
      "jose-elias-alvarez/null-ls.nvim",
      "b0o/schemastore.nvim",
      {
        "j-hui/fidget.nvim",
        config = function()
          require("fidget").setup {}
        end,
      },
    },
    config = function()
      require("plugins.config.lsp").config()
    end,
  }
end

function M.config()
  local servers = {
    gopls = {
      staticcheck = false,
      analyses = {
        unusedparams = false,
      }
    },
    golangci_lint_ls = {
      default_config = {
        cmd = {'golangci-lint-langserver'},
        root_dir = function() return vim.loop.cwd() end,
        init_options = {
          command = {
            "golangci-lint", "run", "--enable-all", "--disable", "lll", "--out-format", "json"
          };
        }
      }
    },
    html = {},
    jsonls = {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
        },
      },
    },
    pyright = {},
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
            -- Make the server aware of Neovim runtime files
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
            },
          },
        },
      },
    },
    tsserver = {},
    vimls = {},
  }

  local opts = require("plugins.config.lsp.config").default_config()

  require("plugins.config.lsp.null-ls").setup(opts)
  require("plugins.config.lsp.installer").setup(servers, opts)
end

return M
