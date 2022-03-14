local M = {}

function M.setup(use)
   use {
      "kevinhwang91/rnvimr",
      cmd = { "RnvimrToggle" },
      keys = { " rr" },
      config = function()
         vim.g.rnvimr_enable_ex = 1
         vim.g.rnvimr_enable_picker = 1
         vim.g.rnvimr_hide_gitignore = 1

         local map = require("utils").map
         map("n", "<leader>rr", ":RnvimrToggle<CR>")
      end,
   }
end

return M
