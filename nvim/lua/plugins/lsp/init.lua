local with_diagnostics_code = function(builtin)
  return builtin.with {
    diagnostics_format = "#{m} [#{c}]",
  }
end

local with_root_file = function(builtin, file)
  return builtin.with {
    condition = function(utils)
      return utils.root_has_file(file)
    end,
  }
end

local with_extra_args = function(builtin, args)
  return builtin.with {
    extra_args = args,
  }
end

return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", config = true },
      { "j-hui/fidget.nvim", config = true },
      { "smjonas/inc-rename.nvim", config = true },
      "simrat39/rust-tools.nvim",
      "rust-lang/rust.vim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = { callSnippet = "Replace" },
              telemetry = { enable = false },
              hint = {
                enable = false,
              },
            },
          },
        },
        dockerls = {},
        bashls = {},
        omnisharp = {},
        emmet_ls = {},
        marksman = {},
        html = {},
      },
      setup = {},
    },
    config = function(plugin, opts)
      require("plugins.lsp.servers").setup(plugin, opts)
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    ensure_installed = {
      "stylua",
      "ruff",
      "delve",
    },
    config = function(plugin)
      require("mason").setup()
      local mr = require "mason-registry"
      for _, tool in ipairs(plugin.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    config = function()
      local nls = require "null-ls"
      local nls_utils = require "null-ls.utils"

      nls.setup {
        debounce = 150,
        save_after_format = false,
        root_dir = nls_utils.root_pattern ".git",
        sources = {
          -- formatting
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.isort,
          nls.builtins.formatting.nginx_beautifier,
          nls.builtins.formatting.prettier,
          nls.builtins.formatting.shfmt,
          with_extra_args(nls.builtins.diagnostics.ruff, { "--max-line-length=90" }),
          with_extra_args(nls.builtins.formatting.fixjson, { "-i", "2" }),
          with_extra_args(nls.builtins.formatting.black, { "--fast" }),
          with_root_file(nls.builtins.formatting.stylua, "stylua.toml"),
          with_extra_args(nls.builtins.formatting.sql_formatter, {
            "--config",
            vim.fn.expand "~/.config/nvim/lua/esequiel378/plugins/lsp/config/sql-formatter.json",
          }),

          -- diagnostics
          nls.builtins.diagnostics.eslint_d,
          nls.builtins.diagnostics.misspell,
          nls.builtins.diagnostics.pyproject_flake8,
          nls.builtins.diagnostics.tsc,
          nls.builtins.diagnostics.write_good,

          with_diagnostics_code(nls.builtins.diagnostics.shellcheck),
          with_root_file(nls.builtins.diagnostics.selene, "selene.toml"),

          -- code actions
          nls.builtins.code_actions.eslint_d,
          nls.builtins.code_actions.proselint,

          -- hover
          nls.builtins.hover.dictionary,
        },
      }
    end,
  },
  {
    "utilyre/barbecue.nvim",
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  },
}
