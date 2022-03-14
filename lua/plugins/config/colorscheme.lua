local M = {}

function M.setup(use)
   use {
      "bluz71/vim-moonfly-colors",
      config = function()
         vim.cmd "colorscheme moonfly"
      end,
   }
end

return M
