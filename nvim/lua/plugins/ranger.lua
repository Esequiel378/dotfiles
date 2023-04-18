return {
  {
    "kevinhwang91/rnvimr",
    cmd = { "RnvimrToggle" },
    config = function()
      vim.g.rnvimr_enable_ex = 1
      vim.g.rnvimr_enable_picker = 1
      vim.g.rnvimr_hide_gitignore = 1
    end,
    keys = {
      { "<leader>rr", ":RnvimrToggle<CR>", desc = "Ranger" },
    },
  },
}
