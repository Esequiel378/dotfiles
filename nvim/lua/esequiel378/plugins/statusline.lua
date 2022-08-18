local M = {}

-- Returns the lsp clients attached to the current buffer as string
-- Example: [sumneko_lua, misspell]
M.lsp_clients = function(msg)
  msg = msg or ""
  local buf_clients = vim.lsp.buf_get_clients()
  if next(buf_clients) == nil then
    if type(msg) == "boolean" or #msg == 0 then
      return ""
    end
    return msg
  end

  local buf_ft = vim.bo.filetype
  local buf_client_names = {}

  -- add client
  for _, client in pairs(buf_clients) do
    if client.name ~= "null-ls" then
      table.insert(buf_client_names, client.name)
    end
  end

  -- add linter
  local linters = require "esequiel378.plugins.lsp.null-ls.linters"
  local supported_linters = linters.list_registered(buf_ft)
  vim.list_extend(buf_client_names, supported_linters)

  return "[" .. table.concat(buf_client_names, ", ") .. "]"
end

M.setup = function(use)
  use {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = M.config,
  }
end

M.config = function()
  require("lualine").setup {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {},
      always_divide_middle = true,
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = {
        { "filename" },
        -- separator
        { "%=" },
        {
          "require'esequiel378.plugins.statusline'.lsp_clients()",
          icon = " ",
          color = { fg = "#a9a1e1", gui = "bold" },
        },
      },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  }
end

return M
