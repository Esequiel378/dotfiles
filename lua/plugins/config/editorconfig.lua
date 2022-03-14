local M = {}

function M.setup(use)
  use {
    "editorconfig/editorconfig-vim",
    config = function ()
      vim.g.EditorConfig_exclude_patterns = {'fugitive://.*', 'scp://.*'}
    end
  }

end

return M
