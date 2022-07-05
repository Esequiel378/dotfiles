local M = {}

M.setup = function(use)
  use {
    "kevinhwang91/rnvimr",
    cmd = { "RnvimrToggle" },
    keys = { "<leader>rr" },
    config = M.config,
  }
end

M.config = function()
  vim.g.rnvimr_enable_ex = 1
  vim.g.rnvimr_enable_picker = 1
  vim.g.rnvimr_hide_gitignore = 1

  local map = require("core.utils").map
  map("n", "<leader>rr", ":RnvimrToggle<CR>")
end

return M
