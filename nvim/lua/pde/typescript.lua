if not require("config").pde.typescript then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, { "javascript", "typescript", "tsx" })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require "null-ls"

      vim.list_extend(opts.sources, {
        -- formatting
        nls.builtins.formatting.prettier,

        -- diagnostics
        nls.builtins.diagnostics.eslint_d,
        nls.builtins.diagnostics.tsc,

        -- code actions
        nls.builtins.code_actions.eslint_d,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    dependencies = { "jose-elias-alvarez/typescript.nvim" },
    opts = {
      servers = {
        tsserver = {},
      },
      setup = {
        tsserver = function(_, opts)
          require("typescript").setup { server = opts }
          return true
        end,
      },
    },
  },
}
