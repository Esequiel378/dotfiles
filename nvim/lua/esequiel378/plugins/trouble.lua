local M = {}

M.setup = function(use)
  use {
    "folke/trouble.nvim",
    wants = "nvim-web-devicons",
    requires = "kyazdani42/nvim-web-devicons",
    keys = { "<leader>q" },
    cmd = { "TroubleToggle", "Trouble" },
    config = M.config,
  }
end

M.config = function()
  local map = require("esequiel378.utils").map

  map("n", "<leader>q", ":TroubleToggle<CR>")

  require("trouble").setup {
    use_diagnostic_signs = true,
  }
end

return M
