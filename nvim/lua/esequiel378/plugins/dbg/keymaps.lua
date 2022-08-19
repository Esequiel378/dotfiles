local map = require("esequiel378.utils").map

local M = {}

M.config = function()
  map("n", "<leader>dct", '<cmd>lua require"dap".continue()<CR>')
  map("n", "<leader>dsv", '<cmd>lua require"dap".step_over()<CR>')
  map("n", "<leader>dsi", '<cmd>lua require"dap".step_into()<CR>')
  map("n", "<leader>dso", '<cmd>lua require"dap".step_out()<CR>')
  map("n", "<leader>dtb", '<cmd>lua require"dap".toggle_breakpoint()<CR>')

  map("n", "<leader>dsc", '<cmd>lua require"dap.ui.variables".scopes()<CR>')
  map("n", "<leader>dhh", '<cmd>lua require"dap.ui.variables".hover()<CR>')
  map("v", "<leader>dhv", '<cmd>lua require"dap.ui.variables".visual_hover()<CR>')

  map("n", "<leader>duh", '<cmd>lua require"dap.ui.widgets".hover()<CR>')
  map("n", "<leader>duf", "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")

  map("n", "<leader>dsbr", '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
  map("n", "<leader>dsbm", '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
  map("n", "<leader>dro", '<cmd>lua require"dap".repl.open()<CR>')
  map("n", "<leader>drl", '<cmd>lua require"dap".repl.run_last()<CR>')
end

return M
