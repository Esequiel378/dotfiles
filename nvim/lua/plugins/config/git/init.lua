local M = {}

M.setup = function(use)
  require("plugins.config.git.fugitive").setup(use)
  require("plugins.config.git.signs").setup(use)
end

return M
