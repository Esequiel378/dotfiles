if not require("config").pde.python then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "python" })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local lsp_utils = require "base.lsp.utils"
      local nls = require "null-ls"

      vim.list_extend(opts.sources, {
        -- formatting
        nls.builtins.formatting.isort,
        lsp_utils.with_extra_args(nls.builtins.formatting.black, { "--fast" }),

        -- diagnostics
        nls.builtins.diagnostics.pydocstyle,
        nls.builtins.diagnostics.mypy,
        lsp_utils.with_extra_args(nls.builtins.diagnostics.ruff, { "--max-line-length=90" }),
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "debugpy", "black", "isort", "pyright", "mypy" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ft = { "python" },
    opts = {
      servers = {
        ruff_lsp = {
          init_options = {
            settings = {
              args = { "--max-line-length=180" },
            },
          },
        },
        pyright = {
          settings = {
            python = {
              analysis = {
                autoImportCompletions = true,
                typeCheckingMode = "off",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace", -- "openFilesOnly",
              },
            },
          },
        },
      },
      setup = {
        pyright = function(_, _)
          local lsp_utils = require "base.lsp.utils"
          lsp_utils.on_attach(function(client, bufnr)
            local map = function(mode, lhs, rhs, desc)
              if desc then
                desc = desc
              end
              vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
            end
            -- stylua: ignore
            if client.name == "pyright" then
              map("n", "<leader>lo", "<cmd>PyrightOrganizeImports<cr>",  "Organize Imports" )
            end
          end)
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      config = function()
        require("dap-python").setup() -- Use default python
      end,
    },
  },
}
