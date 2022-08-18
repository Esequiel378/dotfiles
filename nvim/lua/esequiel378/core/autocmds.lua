local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "IncSearch",
      timeout = 40,
    }
  end,
})

local trim_whitespace_group = augroup("TrimWhitespace", {})

autocmd("BufWritePre", {
  group = trim_whitespace_group,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})
