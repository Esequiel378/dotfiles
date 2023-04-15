return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  keys = {
    { "<leader>tt", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>to", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    { "<leader>tb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>tg", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
    { "<leader>ps", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
  },
  config = true,
}
