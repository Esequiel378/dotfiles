return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      defaults = {
        ["<leader>l"] = { name = "+LSP" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "j-hui/fidget.nvim", config = true },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      servers = {},
      setup = {},
    },
    config = function(plugin, opts)
      require("base.lsp.servers").setup(plugin, opts)
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = "Mason",
    opts = {
      ensure_installed = {
        "shfmt",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require "mason-registry"
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    opts = function()
      local lsp_utils = require "base.lsp.utils"
      local nls = require "null-ls"

      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          -- formatting
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.prismaFmt,
          nls.builtins.formatting.nginx_beautifier,
          lsp_utils.with_extra_args(nls.builtins.formatting.sql_formatter, {
            "--config",
            vim.fn.expand "~/.config/nvim/lua/base/lsp/sql-formatter.json",
          }),

          -- diagnostics
          nls.builtins.diagnostics.misspell,
          nls.builtins.diagnostics.write_good,
          nls.builtins.diagnostics.actionlint,
          nls.builtins.diagnostics.codespell,
          nls.builtins.diagnostics.dotenv_linter,
          nls.builtins.diagnostics.editorconfig_checker,
          nls.builtins.diagnostics.markdownlint,
          nls.builtins.diagnostics.protolint,
          nls.builtins.diagnostics.zsh,
          nls.builtins.diagnostics.vacuum,
          lsp_utils.with_diagnostics_code(nls.builtins.diagnostics.shellcheck),

          -- code actions
          nls.builtins.code_actions.proselint,

          -- hover
          nls.builtins.hover.dictionary,
          nls.builtins.hover.printenv,
        },
      }
    end,
  },
}
