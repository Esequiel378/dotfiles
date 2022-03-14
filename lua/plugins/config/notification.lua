local M = {}

function M.setup(use)
   use {
      "rcarriga/nvim-notify",
      event = "VimEnter",
      config = function()
         vim.notify = require "notify"
      end,
   }
end

return M
