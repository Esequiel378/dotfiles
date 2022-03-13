local map = require("utils").map

-- Keep cursor centered while jumping arround
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
map("i", "<C-i>", "<ESC>^i")

-- Easier navigation between windows
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-j>", "<C-w>j")

-- Undo checkpoints
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", "!", "!<C-g>u")
map("i", "?", "?<C-g>u")
map("i", ":", ":<C-g>u")
map("i", "[", "[<C-g>u")
map("i", "]", "]<C-g>u")
map("i", "{", "{<C-g>u")
map("i", "}", "}<C-g>u")

-- Paste over currently selected text without yanking it
map("v", "p", '"_dP')

-- use `ESC` or `C-c` to turn off search highlighting
map("n", {"<Esc>", "<C-c>"}, ":noh <CR>")
-- Find and replace word under cursor without ask

map("n", "<leader>rw", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>")
-- map("v", "<leader>rw", ":%s/\\%V<c-r><c-w>//g<left><left>")

-- Resizing panes
map("n", "<Left>", ":vertical resize +1<CR>")
map("n", "<Right>", ":vertical resize -1<CR>")
map("n", "<Up>", ":resize -1<CR>")
map("n", "<Down>", ":resize +1<CR>")

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
map("", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("", "k", 'v:count || mode(2)[0:1] == "no" ? "k" : "gk"', { expr = true })
map("", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
