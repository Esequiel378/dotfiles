local M = {}

function M.config()
   require("gitsigns").setup {
      numhl = false,

      sign_priority = 5,
      signs = {
         add = { hl = "GitSignsAdd", text = "|", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
         change = { hl = "GitSignsChange", text = "|", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
         delete = { hl = "GitSignsDelete", text = "|", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
         topdelete = { hl = "GitSignsDelete", text = "|", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
         changedelete = { hl = "GitSignsChange", text = "|", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
      },

      status_formatter = nil, -- Use default
      watch_gitdir = {
         interval = 1000,
      },
      keymaps = {
         ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
         ["v <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
         ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
         ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
         ["v <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
         ["n <leader>hR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
         ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
         ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
         ["n <leader>hS"] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
         ["n <leader>hU"] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',
      },
   }
end

return M
