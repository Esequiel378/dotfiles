local M = {}

M.setup = function(use)
  use {
    "tpope/vim-fugitive",
    keys = { "<leader>gs" },
    config = M.config,
  }
end

M.config = function()
  local map = require("core.utils").map

  map("n", "<leader>gs", ":G<CR>")
  map("n", "<leader>gl", ":diffget //3<CR>")
  map("n", "<leader>gh", ":diffget //2<CR>")
end

return M
