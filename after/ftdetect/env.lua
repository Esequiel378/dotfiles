vim.cmd [[
  augroup env
    autocmd!
    autocmd BufNewFile,BufRead *.env* set syntax=sh
  augroup end
]]
