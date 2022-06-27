local M = {}

function M.setup(use)
  use {
    "rcarriga/nvim-notify",
    event = "VimEnter",
    config = function()
      vim.notify = require "notify"

      require("notify").setup({
        background_colour = "#000000",
      })

    end,
  }
end

return M
