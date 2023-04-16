return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, { "yamlls" })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "b0o/SchemaStore.nvim" },
    opts = {
      servers = {
        yamlls = {
          on_new_config = function(new_config)
            new_config.settings.yamlls.schemas = new_config.settings.yamlls.schemas or {}
            vim.list_extend(new_config.yamlls.json.schemas, require("schemastore").json.schemas())
          end,
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
      },
    },
  },
}
