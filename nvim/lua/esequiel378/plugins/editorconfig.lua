local M = {}

M.setup = function(use)
  use {
    "editorconfig/editorconfig-vim",
    config = M.config,
  }
end

M.config = function()
  vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*" }
end

return M
