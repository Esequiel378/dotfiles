vim.cmd [[
  augroup Dockerfile
    autocmd!
    autocmd BufNewFile,BufRead *Dockerfile* set ft=Dockerfile
  augroup end
]]

vim.cmd [[
  augroup env
    autocmd!
    autocmd BufNewFile,BufRead *.env* set syntax=sh
  augroup end
]]

vim.cmd [[
  augroup gitignore
    au!
    au BufNewFile,BufRead .gitignore set ft=gitignore
  augroup end
]]

vim.cmd [[ hi WinSeparator guibg=None ]]

vim.cmd [[
  augroup makefiles
    au!
    au BufNewFile,BufRead Makefile setlocal noexpandtab
  augroup end
]]
