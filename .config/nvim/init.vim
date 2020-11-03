scriptencoding utf-8
source ~/.config/nvim/plugins.vim

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

" === Python Compiler === "
"
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

" Wrap in try/catch to avoid errors on initial install before plugin is available
try
  " === Denite setup ==="
  " Use ripgrep for searching current directory for files
  " By default, ripgrep will respect rules in .gitignore
  "   --files: Print each file that would be searched (but don't search)
  "   --glob:  Include or exclues files for searching that match the given glob
  "            (aka ignore .git files)
  "
  call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

  " Use ripgrep in place of "grep"
  call denite#custom#var('grep', 'command', ['rg'])

  " Custom options for ripgrep
  "   --vimgrep:  Show results with every match on it's own line
  "   --hidden:   Search hidden directories and files
  "   --heading:  Show the file name above clusters of matches from each file
  "   --S:        Search case insensitively if the pattern is all lowercase
  call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

  " Recommended defaults for ripgrep via Denite docs
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])

  " Remove date from buffer list
  call denite#custom#var('buffer', 'date_format', '')

  " Custom options for Denite
  "   auto_resize             - Auto resize the Denite window height automatically.
  "   prompt                  - Customize denite prompt
  "   direction               - Specify Denite window direction as directly below current pane
  "   winminheight            - Specify min height for Denite window
  "   highlight_mode_insert   - Specify h1-CursorLine in insert mode
  "
  "   prompt_highlight        - Specify color of prompt
  "   highlight_matched_char  - Matched characters highlight
  "   highlight_matched_range - matched range highlight
  let s:denite_options = {'default' : {
        \ 'split': 'floating',
        \ 'start_filter': 1,
        \ 'auto_resize': 1,
        \ 'source_names': 'short',
        \ 'prompt': 'λ ',
        \ 'highlight_matched_char': 'QuickFixLine',
        \ 'highlight_matched_range': 'Visual',
        \ 'highlight_window_background': 'Visual',
        \ 'highlight_filter_background': 'DiffAdd',
        \ 'winrow': 1,
        \ 'vertical_preview': 1
        \ }}

  " Loop through denite options and enable them
  function! s:profile(opts) abort
    for l:fname in keys(a:opts)
      for l:dopt in keys(a:opts[l:fname])
        call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
      endfor
    endfor
  endfunction

  call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry

" === Python === "
" Declare PythonInterpreter command
command! -nargs=0 PythonInterpreter :CocCommand python.setInterpreter

" Map <leader>py to select Python interpreter
nnoremap <leader>py :PythonInterpreter<CR>

" === Coc.nvim === "
" Declare coc extensions
let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-eslint',
      \ 'coc-prettier',
      \ 'coc-vetur',
      \ 'coc-markdownlint',
      \ 'coc-markmap',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-scssmodules',
      \ ]

let g:coc_filetype_map = {
  \ 'htmldjango': 'html',
  \ }

" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" Autocomplete utilities

" For some reason this line break the system
" inoremap <expr> <Enter>    pumvisible() ? "\<C-y>" : "\<Enter>"
inoremap <expr> <Esc>   pumvisible() ? "\<C-e>" : ""
inoremap <expr> <C-j>   pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k>   pumvisible() ? "\<C-p>" : "\<Up>"

" Use vim key inside insert mode
inoremap <expr> <C-h>   pumvisible() ? "" : "\<Left>"
inoremap <expr> <C-l>   pumvisible() ? "" : "\<Right>"

" Use K to show documentation in preview window.
nnoremap <leader> K :call <SID>show_documentation()<CR>

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" === Prettier === "
" Declare Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Map <leader>f to prettier file formater
nnoremap <leader>f :Prettier<CR>

" === Black Formater === "

" Map F9 to python formater
nnoremap <F9> :Black<CR>

" === NERDTree === "

" Show hidden files/directories
let g:NERDTreeShowHidden = 1

" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI = 1

" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']

" Wrap in try/catch to avoid errors on initial install before plugin is available
try

  " === Vim airline ==== "
  " Enable extensions
  let g:airline_extensions = ['branch', 'hunks', 'coc']

  " Update section z to just have line number
  let g:airline_section_z = airline#section#create(['linenr'])

  " Do not draw separators for empty sections (only for the active window) >
  let g:airline_skip_empty_sections = 1

  " Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
  let g:airline#extensions#tabline#formatter = 'unique_tail'

  " Custom setup that removes filetype/whitespace from default vim airline bar
  let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

  " Customize vim airline per filetype
  " 'nerdtree'  - Hide nerdtree status line
  " 'list'      - Only show file type plus current line number out of total
  let g:airline_filetype_overrides = {
        \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', ''), '' ],
        \ 'list': [ '%y', '%l/%L'],
        \ }

  " Enable powerline fonts
  let g:airline_powerline_fonts = 1
  let g:Powerline_symbols='unicode'

  " Enable caching of syntax highlighting groups
  let g:airline_highlighting_cache = 1

  " Define custom airline symbols
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " Don't show git changes to current file in airline
  let g:airline#extensions#hunks#enabled=0

catch
  echo 'Airline not installed. It should work after running :PlugInstall'
endtry

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
" ===                      CUSTOM COLORSCHEME CHANGES                      === "
" ============================================================================ "
function! Handle_Win_Enter()
  if &previewwindow
    setlocal winhighlight=Normal:MarkdownError
  endif
endfunction

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" Switch dark/light background
function! Solar_swap()
  if &background ==? 'dark'
    set background=light
  else
    set background=dark
  endif
endfunction

" Key binding to switch background color
nmap <leader>bc :call Solar_swap()<CR>

" Default editor theme
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

let g:gruvbox_invert_selection=0
colorscheme gruvbox
set background=dark

" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" === Sweet Sweet FuGITive == "
"  <leader>gs     - Open git status in a new buffer
"  <leader>gh     - Get changes from left panel
"  <leader>gl     - Get changes from rigth buffer
nmap <leader>gs :G<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gj :diffget //3<CR>

" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap ; :Denite buffer<CR>
nmap <leader>t :DeniteProjectDir file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <C-c>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
        \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
        \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
        \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <C-c>
        \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <C-c>
        \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
        \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
        \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
        \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h>
        \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
        \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
        \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
        \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
        \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
        \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
        \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
        \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
        \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
        \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
        \ denite#do_map('do_action', 'split')
endfunction

" === Nerdtree shorcuts === "
"  <leader>n - Toggle NERDTree on/off
"  <leader>f - Opens current file location in NERDTree
nmap <C-n> :NERDTreeToggle<CR>
nmap <C-f> :NERDTreeFind<CR>

" Quick window switching
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" === coc.nvim === "
"   <leader>gd    - Jump to definition of current symbol
"   <leader>gd    - Jump to type-definition of current symbol
"   <leader>gd    - Jump to definition of current symbol
"   <leader>gi    - Jump to implementation of current symbol
"   <leader>gr    - Jump to references of current symbol
"   <leader>ds    - Fuzzy search current project symbols
"   <leader>g[    - go to prev coc-diagnostic (error/warning)
"   <leader>g]    - go to next coc-diagnostic (error/warning)
"   <leader>gp    - go to prev error
"   <leader>gn    - go to next error
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nnoremap <silent> <leader>ds :<C-u>CocList -I -N --top symbols<CR>
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)

" Refresh autocomplete
inoremap <silent><expr> <C-space> coc#refresh()

" === vim-better-whitespace === "

"   <leader>y - Automatically remove trailing whitespace
nmap <leader>y :StripWhitespace<CR>

" === Search shorcuts === "

"   <leader>h - Find and replace
"   <leader>hw - Find and replace word under cursor without ask
"   <leader>hww - Find and replace word under cursor asking one by one
"   <leader>/ - Claer highlighted search terms while preserving history
map <leader>h :%s///<left><left>
map <leader>hw :%s/<c-r><c-w>//g<left><left>
map <leader>hww :%s/<c-r><c-w>//gc<left><left><left>
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

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Move selection/lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

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

augroup FormatFiles
  " trim spaces on files save
  autocmd BufWritePre * :StripWhitespace

  " Format files with prettier
  " autocmd BufWritePre *.ts,*.js,*.vue,*.html,*.css :Prettier
  autocmd BufWritePre *.ts,*.vue,*.css :Prettier

  " Format python on save
  " autocmd BufWritePre *.py execute ':Black'
augroup END

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
