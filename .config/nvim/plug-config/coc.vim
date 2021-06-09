" Declare coc extensions
let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-eslint',
      \ 'coc-prettier',
      \ 'coc-markdownlint',
      \ 'coc-marketplace',
      \ 'coc-markmap',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-scssmodules',
      \ 'coc-python',
      \ 'coc-tailwindcss',
      \ 'coc-rls',
      \ 'coc-toml',
      \ 'coc-elixir',
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


" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" Autocomplete utilities

" For some reason this line break the system
" inoremap <expr> <Enter>    pumvisible() ? "\<C-y>" : "\<Enter>"
inoremap <expr> <Esc>   pumvisible() ? "\<C-e>" : ""
inoremap <expr> <C-j>   pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k>   pumvisible() ? "\<C-p>" : "\<Up>"

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

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

