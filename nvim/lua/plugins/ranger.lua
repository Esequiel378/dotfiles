return {
  {
    "kevinhwang91/rnvimr",
    cmd = { "RnvimrToggle" },
    config = function()
      vim.g.rnvimr_enable_ex = 1
      vim.g.rnvimr_enable_picker = 1
      vim.g.rnvimr_hide_gitignore = 1
    end,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next ToDo" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous ToDo" },
      { "<leader>ct", "<cmd>TodoQuickFix<cr>", desc = "ToDo (Trouble)" },
      { "<leader>cT", "<cmd>TodoTelescope<cr>", desc = "ToDo" },
    },
  },
}
