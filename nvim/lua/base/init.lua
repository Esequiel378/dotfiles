return {
  { "tpope/vim-surround", event = "VeryLazy" },
  { "tpope/vim-sleuth", event = "VeryLazy" },
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "nvim-lua/plenary.nvim" },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      defaults = {
        ["<leader>g"] = { name = "+Git" },
      },
    },
  },
}
