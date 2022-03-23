local g = vim.g
local opt = vim.opt
local wo = vim.wo
local bo = vim.bo

opt.cul = true -- cursor line
bo.swapfile = false
g.backup = false
opt.mouse = "nv"
opt.autoread = true
opt.backup = false
opt.clipboard:append "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.cursorline = true
opt.errorbells = false
opt.fillchars:append "vert:|"
opt.guicursor = "i:block"
opt.hlsearch = true
opt.incsearch = true
opt.ruler = false
opt.scrolloff = 8
opt.shiftwidth = 4
opt.shortmess:append "FWc" -- Don't give completion messages like 'match 1 of 2' or 'The only match'
opt.showcmd = false
opt.showmode = false
opt.signcolumn = "yes"
opt.softtabstop = 4
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.autoindent = true
opt.expandtab = true
opt.tabstop = 4
opt.termguicolors = true
opt.breakindent = true --Enable break indent
opt.title = true
opt.undodir = vim.fn.expand "~/.vim/undodir"
opt.undofile = true
opt.updatetime = 100
opt.whichwrap:append "<>[]hl" -- go to previous/next line when cursor reaches end/beginning of line
opt.winbl = 10
opt.wrap = false
wo.number = true
wo.relativenumber = true

g.omni_sql_no_default_maps = true
g.pascal_delphi = true

-- disable some builtin vim plugins
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
