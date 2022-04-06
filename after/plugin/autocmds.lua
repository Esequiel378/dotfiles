-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- nginx
-- vim.cmd [[
--   augroup nginx
--     autocmd!
--     autocmd BufNewFile,BufRead *nginx* set ft=nginx
--   augroup end
-- ]]

vim.cmd [[ hi WinSeparator guibg=None ]]
