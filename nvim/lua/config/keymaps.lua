local keymap = vim.keymap.set

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Better viewing
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "g,", "g,zvzz")
keymap("n", "g;", "g;zvzz")

-- Navigation within insert mode
keymap("i", "<C-h>", "<Left>")
keymap("i", "<C-e>", "<End>")
keymap("i", "<C-l>", "<Right>")
keymap("i", "<C-k>", "<Up>")
keymap("i", "<C-j>", "<Down>")
keymap("i", "<C-a>", "<ESC>^i")

-- Easier navigation between windows
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-l>", "<C-w>l")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-j>", "<C-w>j")

-- Scrolling
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Add undo break-points
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ";", ";<c-g>u")

-- Better indent
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Resize window using arrow keys
keymap("n", "<Up>", "<cmd>resize +2<CR>")
keymap("n", "<Down>", "<cmd>resize -2<CR>")
keymap("n", "<Left>", "<cmd>vertical resize -2<CR>")
keymap("n", "<Right>", "<cmd>vertical resize +2<CR>")

-- Switching tabs
keymap("n", "<C-Left>", ":tabprevious<CR>")
keymap("n", "<C-Right>", ":tabnext<CR>")

-- Auto indent
keymap("n", "i", function()
  if #vim.fn.getline "." == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true })
