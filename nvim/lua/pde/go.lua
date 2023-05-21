if not require("config").pde.go then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "go", "gomod" })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "delve",
        "gotests",
        "golangci-lint",
        "gofumpt",
        "goimports",
        "golangci-lint-langserver",
        "impl",
        "gomodifytags",
        "iferr",
        "gotestsum",
      })
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    config = function(_, opts)
      require("go").setup(opts)
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              staticcheck = true,
              semanticTokens = true,
            },
          },
        },
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
      },
      setup = {
        gopls = function(_, _)
          local lsp_utils = require "base.lsp.utils"
          lsp_utils.on_attach(function(client, bufnr)
            local map = function(mode, lhs, rhs, desc)
              if desc then
                desc = desc
              end
              vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
            end
            -- stylua: ignore
            if client.name == "gopls" then
              map("n", "<leader>gg", "<cmd>GoGenerate<Cr>", "Go Generate")
              map("n", "<leader>ga", "<cmd>GoAlt<Cr>", "Go Alt Test")
              map("n", "<leader>gR", "<cmd>GoCodeLenAct<Cr>", "Go Run")
              map("n", "<leader>gT", "<cmd>lua require('dap-go').debug_test()<cr>", "Go Debug Test")
            end
          end)
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = { "leoluz/nvim-dap-go", opts = {} },
  },
  {
    "rafaelsq/nvim-goc.lua",
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
      { "<leader>gcr", function() require("nvim-goc").Coverage() end, desc = "Go Coverage", },
      { "<leader>gcc", function() require("nvim-goc").ClearCoverage() end, desc = "Go Clear Coverage", },
      { "<leader>gcf", function() require("nvim-goc").CoverageFunc() end, desc = "Go Coverage Function", },
    },
    config = function()
      -- if set, when we switch between buffers, it will not split more than once. It will switch to the existing buffer instead
      vim.opt.switchbuf = "useopen"

      require("nvim-goc").setup {
        verticalSplit = false,
      }
    end,
  },
}