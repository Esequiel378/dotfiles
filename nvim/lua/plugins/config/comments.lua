local M = {}

function M.setup(use)
   use {
      "tpope/vim-commentary",
      keys = { "gc", "gcc", "gbc" },
   }
end

return M
