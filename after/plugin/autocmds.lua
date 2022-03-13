-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- Dockerfile
vim.cmd [[
  augroup Dockerfile
    autocmd!
    autocmd BufNewFile,BufRead *Dockerfile* set ft=Dockerfile
  augroup end
]]

-- eslang
vim.cmd [[
  augroup eslang
    autocmd!
    autocmd BufNewFile,BufRead *.esl* set syntax=pascal
  augroup end
]]
