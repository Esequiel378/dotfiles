" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" === Prettier === "

" Declare Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Map <leader>f to prettier file formater
nnoremap <leader>f :Prettier<CR>


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
  " autocmd BufWritePre *.py execute ':Black'
augroup END

