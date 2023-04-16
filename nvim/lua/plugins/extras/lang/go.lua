return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, { "gopls", "golangci_lint_ls" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
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
      },
    },
  },
}
