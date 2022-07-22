local M = {}

M.setup = function(use)
  use {
    "RishabhRD/nvim-cheat.sh",
    requires = {
      "RishabhRD/popfix",
    },
    setup = function()
      local map = require("core.utils").map

      map("n", "<leader>cs", ":Cheat <CR>")
    end,
  }
end

return M
