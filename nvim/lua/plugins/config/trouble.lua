local M = {}

M.setup = function(use)
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = M.config,
  }
end

M.config = function()
  local map = require("core.utils").map

  map("n", "<leader>q", ":TroubleToggle<CR>")
  require("trouble").setup {}
end

return M
