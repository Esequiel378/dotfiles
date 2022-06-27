local M = {}

M.setup = function(use)
  use {
    "bluz71/vim-moonfly-colors",
    config = function()
      vim.cmd "colorscheme moonfly"
      -- vim.cmd "hi Normal guibg=0000"
    end,
  }
end

return M
