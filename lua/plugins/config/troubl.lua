
local M = {}

function M.setup(use)
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      local map = require("utils").map
      map("n", "<leader>q", ":TroubleToggle<CR>")

      require("trouble").setup{}
    end,
  }

end

return M
