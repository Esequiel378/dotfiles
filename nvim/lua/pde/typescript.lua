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
    "neovim/nvim-lspconfig",
    dependencies = { "jose-elias-alvarez/typescript.nvim" },
    opts = {
      servers = {
        tsserver = {},
      },
      setup = {
        tsserver = function(_, opts)
          local lsp_utils = require "plugins.lsp.utils"
          require("typescript").setup { server = opts }
          return true
        end,
      },
    },
    keys = {
      { "<leader>oi", "TypescriptOrganizeImports", desc = "Organize Imports" },
      { "<leader>rf", "TypescriptRenameFile", desc = "Rename File" },
    },
  },
}
