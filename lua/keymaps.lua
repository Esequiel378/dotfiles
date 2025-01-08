-- [[ Navigation with Word Wrap ]]
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Move up with wrap support" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Move down with wrap support" })

-- [[ Improved Viewing ]]
vim.keymap.set("n", "n", "nzzzv", { desc = "Search next with centered view" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search previous with centered view" })
vim.keymap.set("n", "g,", "g,zvzz", { desc = "Go to next change and center" })
vim.keymap.set("n", "g;", "g;zvzz", { desc = "Go to previous change and center" })

-- [[ Insert Mode Navigation ]]
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move left in insert mode" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move right in insert mode" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move up in insert mode" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move down in insert mode" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "Move to end of line in insert mode" })
vim.keymap.set("i", "<C-a>", "<ESC>^i", { desc = "Move to beginning of line in insert mode" })

-- [[ Window Navigation ]]
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })

-- [[ Scrolling ]]
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- [[ Undo Breakpoints ]]
vim.keymap.set("i", ",", ",<c-g>u", { desc = "Undo break after ',' in insert mode" })
vim.keymap.set("i", ".", ".<c-g>u", { desc = "Undo break after '.' in insert mode" })
vim.keymap.set("i", ";", ";<c-g>u", { desc = "Undo break after ';' in insert mode" })

-- [[ Visual Mode Indenting ]]
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- [[ Window Resizing ]]
vim.keymap.set("n", "<Up>", "<cmd>resize +2<CR>", { desc = "Increase height" })
vim.keymap.set("n", "<Down>", "<cmd>resize -2<CR>", { desc = "Decrease height" })
vim.keymap.set("n", "<Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease width" })
vim.keymap.set("n", "<Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase width" })

-- [[ Tab Navigation ]]
vim.keymap.set("n", "<C-Left>", ":tabprevious<CR>", { desc = "Go to previous tab" })
vim.keymap.set("n", "<C-Right>", ":tabnext<CR>", { desc = "Go to next tab" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- [[ Auto Indent in Normal Mode ]]
vim.keymap.set("n", "i", function()
  if #vim.fn.getline "." == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true, desc = "Auto indent or enter insert mode" })
