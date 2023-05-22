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
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    opts = {},
    config = function(_, opts)
      local utils = require "base.lsp.utils"

      require("go").setup {
        goimport = "goimports",
        gofmt = "gofumpt",
        max_line_len = 90,
        comment_placeholder = "",
        lsp_cfg = {
          capabilities = utils.capabilities(),
        },
        dap_debug = true,
        lsp_codelens = true,
        lsp_inlay_hints = {
          enable = false,
        },
      }

      -- Run gofmt + goimport on save
      local format_sync_grp = vim.api.nvim_create_augroup("format_sync", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimport()
        end,
        group = format_sync_grp,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ft = { "go", "gomod" },
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
              map("n", "<leader>gD", "<cmd>lua require('dap-go').debug_test()<cr>", "Go Debug Test")
              map("n", "<leader>gt", "<cmd>GoTest<cr>", "Go Test File")
              map("n", "<leader>gtf", "<cmd>GoTestFunc<cr>", "Go Test Function")
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
  {
    "jeniasaigak/goplay.nvim",
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    config = function()
      require("goplay").setup()
    end,
    -- stylua: ignore
    keys = {
      { "<leader>gp", function() require("goplay").goPlaygroundToggle() end, desc = "Go Playground", },
      { "<leader>gpr", "<cmd>GPExec<cr>" , desc = "Go Exec Playground", },
    },
  },
}
