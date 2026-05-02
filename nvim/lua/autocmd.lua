-- [[ Utility Function to Create Autocommand Groups ]]
local function augroup(name)
  return vim.api.nvim_create_augroup("nde_" .. name, { clear = true })
end

-- [[ Autocommands ]]

-- Highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Restore cursor to the last location when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Automatically reload files changed outside of Neovim
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = augroup("auto_reload"),
  command = "checktime",
})

-- Show cursorline only in the active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  group = augroup("cursorline_toggle"),
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  group = augroup("cursorline_toggle"),
  callback = function()
    if vim.wo.cursorline then
      vim.api.nvim_win_set_var(0, "auto-cursorline", true)
      vim.wo.cursorline = false
    end
  end,
})

-- Workaround for Telescope insert mode escape issue
vim.api.nvim_create_autocmd("WinLeave", {
  group = augroup("telescope_fix"),
  callback = function()
    if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
    end
  end,
})
