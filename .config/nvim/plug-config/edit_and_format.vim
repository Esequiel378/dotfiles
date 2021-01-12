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
" Declare PythonInterpreter command
command! -nargs=0 PythonInterpreter :CocCommand python.setInterpreter

" === Black Formater === "

" Map F9 to python formater
nnoremap <F9> :Black<CR>

" ============================================================================ "
" ===                             GROUPS                                   === "
" ============================================================================ "

augroup FormatFiles
  " trim spaces on files save
  autocmd BufWritePre * :StripWhitespace

  " Format files with prettier
  " autocmd BufWritePre *.ts,*.js,*.vue,*.html,*.css :Prettier

  " Format python on save
  autocmd BufWritePre *.py execute ':Black'
augroup END
