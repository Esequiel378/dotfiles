-- Set mapleader
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", {
  noremap = true, silent = true
})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- UI
vim.wo.rnu = true
vim.wo.nu = true
vim.opt.laststatus = 3
vim.opt.fillchars:append "vert:|"
vim.opt.scrolloff = 8
vim.opt.isfname:append "@-@"
vim.opt.shortmess:append "FWc"
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.bri = true
vim.opt.title = true
vim.winbl = 10
vim.cmdheigh = 1
vim.opt.colorcolumn = "90"
vim.opt.pumheight = 10

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Backgropund?
vim.opt.autoread = true
vim.opt.errorbells = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.updatetime = 50

-- Cursor
vim.opt.cul = true
vim.opt.tgc = true
vim.opt.guicursor = "i:block"
vim.opt.mouse = "nv"

-- Go to previous/next line when cursor reaches end/beginning of line
vim.opt.whichwrap:append "<>[]hl"

-- Enable vim to interact with the system clipboard
vim.opt.clipboard:append "unnamedplus"

-- File history
vim.bo.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.expand "~/.vim/undodir"
vim.opt.undofile = true

-- Remove sql wire stuffs
vim.g.omni_sql_no_default_maps = true
vim.g.pascal_delphi = true

-- Disable some builtin vim plugins
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "matchit",
  "matchparen",
  "netrw",
  "netrwFileHandlers",
  "netrwPlugin",
  "netrwSettings",
  "rrhelper",
  "spellfile_plugin",
  "tar",
  "tarPlugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end
