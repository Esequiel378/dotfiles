local keymap = vim.keymap.set

keymap("n", "c", function ()
  vim.cmd ":DiffviewClose"
  vim.cmd ":G<CR><C-w>T"
  vim.cmd ":G commit"
end)
