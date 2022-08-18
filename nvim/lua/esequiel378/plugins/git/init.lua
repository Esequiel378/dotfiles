local M = {}

M.setup = function(use)
  require("esequiel378.plugins.git.fugitive").setup(use)
  require("esequiel378.plugins.git.signs").setup(use)
end

return M
