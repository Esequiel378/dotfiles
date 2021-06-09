" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" Move selection/lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" === Prettier === "

" Declare Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Map <leader>f to prettier file formater
nnoremap <leader>f :Prettier<CR>

" === Python === "

" Isort
let g:vim_isort_map = '<C-i>'
let g:vim_isort_python_version = 'python3'
let g:vim_isort_config_overrides = {
  \ 'include_trailing_comma': 1,
  \ 'multi_line_output': 3
  \}

" Declare PythonInterpreter command
command! -nargs=0 PythonInterpreter :CocCommand python.setInterpreter

" Format file sort imports
function FormatPythonFile()
  execute "Isort"
  execute "Black"
endfunction

" Map F9 to python formater
nnoremap <F9> :call FormatPythonFile()<CR>

" === Rust === "
let g:rustfmt_autosave = 1

" ============================================================================ "
" ===                             GROUPS                                   === "
" ============================================================================ "

augroup FormatFiles
  " trim spaces on files save
  autocmd BufWritePre * :StripWhitespace

  " Format files with prettier
  " autocmd BufWritePre *.ts,*.js,*.vue,*.html,*.css :Prettier

  " Format python on save
  autocmd BufWritePre *.py :call FormatPythonFile()
augroup END
