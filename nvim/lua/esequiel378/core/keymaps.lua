local map = require("esequiel378.utils").map

-- Keep cursor centered while jumping around
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")

-- Better indent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Navigation within insert mode
map("i", "<C-h>", "<Left>")
map("i", "<C-e>", "<End>")
map("i", "<C-l>", "<Right>")
map("i", "<C-k>", "<Up>")
map("i", "<C-j>", "<Down>")
map("i", "<C-a>", "<ESC>^i")

-- Easier navigation between windows
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-j>", "<C-w>j")

-- Paste over currently selected text without yanking it
map("v", "p", '"_dP')

-- use `ESC` or `C-c` to turn off search highlighting
map("n", { "<Esc>", "<C-c>" }, ":noh <CR>")

-- Resizing panes
map("n", "<Left>", ":vertical resize +1<CR>")
map("n", "<Right>", ":vertical resize -1<CR>")
map("n", "<Up>", ":resize +1<CR>")
map("n", "<Down>", ":resize -1<CR>")

-- Remove extra blank lines from file
map("n", "<leader>rbl", ":%s/\\(\\n\\n\\)\\n\\+/\\1/<CR>")
