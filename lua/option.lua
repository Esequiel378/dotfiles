-- [[ Leader Keys ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ General Settings ]]
vim.g.have_nerd_font = true
vim.g.equalalways = true
vim.g.errorbells = true
vim.g.previewpopup = true
vim.g.showtabline = true

-- [[ Key Mappings ]]
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- [[ Indentation ]]
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.shiftround = true

-- [[ UI Settings ]]
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.laststatus = 3 -- Global statusline
vim.opt.scrollback = 100000
vim.opt.scrolloff = 8 -- Vertical scroll margin
vim.opt.sidescrolloff = 8 -- Horizontal scroll margin
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "screen" -- Adjust for version compatibility
vim.opt.title = true
vim.opt.winblend = 10 -- Window transparency
vim.opt.cmdheight = 1 -- Command line height
vim.opt.termguicolors = true
vim.opt.colorcolumn = "90,120" -- Highlight these columns
vim.opt.pumblend = 10 -- Popup menu transparency
vim.opt.pumheight = 10 -- Max items in popup menu
vim.opt.completeopt = "menuone,noselect" -- Completion options
vim.opt.conceallevel = 0 -- Show all text (no concealment)
vim.opt.showcmd = false -- Hide command display
vim.opt.showmode = false -- Hide mode in statusline
vim.opt.wrap = true
vim.opt.linebreak = true -- Wrap lines at word boundaries
vim.opt.showbreak = "↪ " -- Symbol for wrapped lines
vim.opt.joinspaces = false -- Avoid double spaces after punctuation
vim.opt.visualbell = true -- Visual instead of audio error indication

-- [[ Search & Replace ]]
vim.opt.hlsearch = true -- Highlight search matches
vim.opt.incsearch = true -- Incremental search
vim.opt.inccommand = "nosplit" -- Live substitution preview
vim.opt.ignorecase = true -- Ignore case in search
vim.opt.smartcase = true -- Override ignorecase if uppercase is used
vim.opt.wrapscan = true -- Wrap search around file
vim.opt.wildignore = "*.o,*.obj,*.bak,*.exe,*.pyc,*.class,*.cache"

-- [[ System Settings ]]
vim.opt.clipboard:append("unnamed") -- Use system clipboard
vim.opt.confirm = true -- Confirm save before exiting
vim.opt.formatoptions = vim.opt.formatoptions + "cro" -- Format adjustments
vim.opt.hidden = true -- Allow background buffers
vim.opt.wildmode = "longest:full,full" -- Completion mode
vim.opt.timeoutlen = 300 -- Shorter timeout for mapped sequences
vim.opt.updatetime = 100 -- Faster UI response
vim.opt.lazyredraw = true -- Performance for macros/large files
vim.opt.synmaxcol = 300 -- Limit syntax highlight column

-- [[ Cursor Behavior ]]
vim.opt.cursorline = true -- Highlight current line
vim.opt.mouse = "a" -- Enable mouse
vim.opt.guicursor = "i:block" -- Block cursor in insert mode

-- [[ Folding ]]
vim.opt.foldcolumn = "1" -- Show fold column
vim.opt.foldenable = true -- Enable folding
vim.opt.foldlevel = 99 -- Start with all folds open
vim.opt.foldlevelstart = 99

-- [[ Undo and Backup ]]
vim.opt.swapfile = false -- Disable swapfile
vim.opt.backup = false -- Disable backup files
vim.opt.undodir = { vim.fn.expand("~/.vim/undodir") }
vim.opt.undofile = true -- Enable undo history
vim.opt.undolevels = 10000 -- Keep many undo levels
vim.opt.undoreload = 10000 -- Reload large undo files

-- [[ Key Behavior ]]
vim.opt.whichwrap:append("<>[]hl") -- Allow wrapping with arrow keys

-- [[ Markdown Settings ]]
vim.g.markdown_recommended_style = 0 -- Disable markdown recommended settings

-- [[ Plugin-Specific ]]
vim.g.omni_sql_no_default_maps = true -- Disable default SQL omni mappings
vim.g.pascal_delphi = true -- Enable Pascal/Delphi syntax support

-- [[ Completion Experience ]]
vim.opt.shortmess:append("c") -- Suppress completion messages
