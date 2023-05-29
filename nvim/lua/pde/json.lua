if not require("config").pde.json then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, { "json", "json5", "jsonc" })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local lsp_utils = require "base.lsp.utils"
      local nls = require "null-ls"

      vim.list_extend(opts.sources, {
        -- formatting
        lsp_utils.with_extra_args(nls.builtins.formatting.fixjson, { "-i", "2" }),

        -- diagnostics
        lsp_utils.with_extra_args(nls.builtins.diagnostics.ruff, { "--max-line-length=90" }),
        nls.builtins.diagnostics.yamllint,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ft = { "json" },
    dependencies = { "b0o/SchemaStore.nvim" },
    opts = {
      servers = {
        jsonls = {
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = { enable = true },
            },
          },
        },
      },
    },
  },
}
