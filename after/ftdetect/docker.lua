vim.cmd [[
  augroup Dockerfile
    autocmd!
    autocmd BufNewFile,BufRead *Dockerfile* set ft=Dockerfile
  augroup end
]]
