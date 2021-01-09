scriptencoding utf-8
source $HOME/.config/nvim/plugins.vim

" ============================================================================ "
" ===                           EDITING OPTIONS                            === "
" ============================================================================ "

" Remap leader key to space
let g:mapleader=' '

" Disable line numbers
set nonumber

" Don't show last command
set noshowcmd

" Yank and paste with the system clipboard
set clipboard=unnamedplus

" Hides buffers instead of closing them
set hidden

" === TAB/Space settings === "

" Insert spaces when TAB is pressed.
set expandtab

" Change number of spaces that a <Tab> counts for during editing ops
set softtabstop=2

" Indentation amount for < and > commands.
set shiftwidth=2

" do not wrap long lines by default
set nowrap

" Don't highlight current cursor line
set nocursorline

" Disable line/column number in status line
" Shows up in preview window when airline is disabled if not
set noruler

" Only one line for command line
set cmdheight=1

" === Completion Settings === "

" Don't give completion messages like 'match 1 of 2'
" or 'The only match'
set shortmess+=c


" ============================================================================ "
" ===                           PLUGIN SETUP                               === "
" ============================================================================ "


source $HOME/.config/nvim/plug-config/airline.vim
source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/color_scheme.vim
source $HOME/.config/nvim/plug-config/denite.vim
source $HOME/.config/nvim/plug-config/edit_and_format.vim
source $HOME/.config/nvim/plug-config/rnvimr.vim


" Trigger configuration
" let g:UltiSnipsExpandTrigger="<C-l>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"


" === Python Compiler === "

" Ignore Python warnings - useful for vim-htmldjango_omnicomplete
let $PYTHONWARNINGS="ignore"

" === Polyglot === "
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1

let python_highlight_all=1

" === Highlight Yanked Text === "

" Time that yanked will be selected
let g:highlightedyank_highlight_duration = 100

" === Blamer === "
let g:blamer_enabled = 0
let g:blamer_delay = 1
let g:blamer_relative_time = 1
let g:blamer_show_in_visual_modes = 0

" === vim-jsx === "
" Highlight jsx syntax even in non .jsx files
let g:jsx_ext_required = 1

" === Signify === "
let g:signify_sign_delete = '-'

set updatetime=100


" ============================================================================ "
" ===                                UI                                    === "
" ============================================================================ "

" Enable true color support
set termguicolors

" Change vertical split character to be a space (essentially hide it)
set fillchars+=vert:.

" Set preview window to appear at bottom
set splitbelow

" Don't dispay mode in command line (airilne already shows it)
set noshowmode

" Set floating window to be slightly transparent
set winbl=10

" Enable line numbers
set number relativenumber


" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" === Sweet Sweet FuGITive == "
"  <leader>gs     - Open git status in a new buffer
"  <leader>gh     - Get changes from left panel
"  <leader>gl     - Get changes from rigth buffer
nmap <leader>gs :G<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gh :diffget //3<CR>

" Quick window switching
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Use vim key inside insert mode
inoremap <expr> <C-h>   pumvisible() ? "" : "\<Left>"
inoremap <expr> <C-l>   pumvisible() ? "" : "\<Right>"

" === vim-better-whitespace === "

"   <leader>y - Automatically remove trailing whitespace
nmap <leader>y :StripWhitespace<CR>

" Declare PythonInterpreter command
command! -nargs=0 PythonInterpreter :CocCommand python.setInterpreter

" Map <leader>py to select Python interpreter
nnoremap <leader>py :PythonInterpreter<CR>

" === Search shorcuts === "

"   <leader>h - Find and replace word under cursor without ask
"   <leader>hw - Find and replace word under cursor asking one by one
"   <leader>/ - Claer highlighted search terms while preserving history
map <leader>h :%s/<c-r><c-w>//g<left><left>
map <leader>hw :%s/<c-r><c-w>//gc<left><left><left>
nmap <silent> <leader>/ :nohlsearch<CR>

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to
" Vim's default buffer
noremap <leader>p "_dP


" ============================================================================ "
" ===                                 MISC.                                === "
" ============================================================================ "

" bind ctrl+c to Escape key to exit modes
nnoremap <C-c> <esc>
inoremap <C-c> <esc>
vnoremap <C-c> <esc>

" Source init.vim
nnoremap <leader><cr> :so ~/.config/nvim/init.vim<cr>

" Open Undo tree window
nnoremap <leader>u :UndotreeShow<CR>

" === Search === "

" ignore case when searching
set ignorecase

" if the search string has an upper case letter in it, the search will be case sensitive
set smartcase

" Automatically re-read file if a change was detected outside of vim
set autoread

augroup FilesTypes
  " Enable spellcheck for markdown files
  autocmd BufRead,BufNewFile *.md setlocal spell

  " Python files config
  au BufNewFile,BufRead *.py
   \ set tabstop=4 |
   \ set softtabstop=4 |
   \ set shiftwidth=4 |
   \ set expandtab |
   \ set autoindent |
   \ set fileformat=unix |

  " html js and css files config
  au BufNewFile,BufRead *.ts,*.js,*.vue,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set formatprg=prettier

  autocmd FileType html,htmldjango setlocal expandtab shiftwidth=2 tabstop=2
augroup END

" Fire Neovim
" augroup FireNeovim
  " au BufEnter github.com_*.txt set filetype=markdown
  " au BufEnter txti.es_*.txt set filetype=typescript
  " au BufEnter gitlab.com_*.txt set filetype=markdown
  " au BufEnter localhost*.txt set filetype=json
  " au BufEnter *tenant*.txt set filetype=json
" augroup END

" Set backups
if has('persistent_undo')
  set undofile
  set undolevels=3000
  set undoreload=10000
endif

set backupdir=~/.local/share/nvim/backup " Don't put backups in current dir
set backup
set noswapfile

" Reload icons after init source
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" In order to open large files
augroup LargeFile
  let g:large_file = 10485760 " 10MB

  " Set options:
  "   eventignore+=FileType (no syntax hihlighting etc
  "   assumes FileType always on)
  "   noswapfile (save copy of file)
  "   bufhidden=unload (save memory when other file is viewed)
  "   buftype=nowritefile (is read-only)
  "   undolevels=-1 (no undo possible)
  au BufReadPre *
        \ let f=expand("<afile>") |
        \ if getfsize(f) > g:large_file |
        \ set eventignore+=FileType |
        \ setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 |
        \ else |
        \ set eventignore-=FileType |
        \ endif
augroup END
