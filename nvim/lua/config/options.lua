local opt = vim.opt

-- Indent
opt.tabstop = 2
opt.autoindent = true
opt.smartindent = true
opt.smartcase = true
opt.breakindent = true
opt.expandtab = true
opt.ignorecase = true
opt.shiftround = true
opt.shiftwidth = 2

-- UI
opt.number = true
opt.relativenumber = true
opt.laststatus = 3
opt.scrollback = 100000
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.title = true
opt.winbl = 10
opt.cmdheight = 1
opt.termguicolors = true
opt.colorcolumn = "90"
opt.pumblend = 10
opt.pumheight = 10
opt.completeopt = "menuone,noselect"
opt.conceallevel = 0
opt.showcmd = false
opt.showmode = false
opt.fillchars = "vert:|"
-- opt.fillchars:append "vert:|"
-- opt.isfname:append "@-@"
-- opt.shortmess:append "FWc"
-- opt.list = true

opt.joinspaces = false

-- Search & Replace
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = "nosplit"

-- System
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.confirm = true
opt.formatoptions = "jqlnt" -- tcqj
opt.hidden = true
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.wildmode = "longest:full,full"
opt.timeoutlen = 300
opt.undofile = true
opt.updatetime = 100

-- Cursor
opt.cursorline = true
opt.mouse = "a"
opt.guicursor = "i:block"

-- Fold
opt.foldcolumn = "1" -- '0' is not bad
opt.foldenable = true
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99

-- File history
opt.swapfile = false
opt.backup = false
opt.undodir = { vim.fn.expand "~/.vim/undodir" }
opt.undofile = true

-- Go to previous/next line when cursor reaches end/beginning of line
vim.g.whichwrap = "<>[]hl"
-- opt.whichwrap:append "<>[]hl"

-- Remove sql wire stuffs
vim.g.omni_sql_no_default_maps = true
vim.g.pascal_delphi = true

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.markdown_recommended_style = 0

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
