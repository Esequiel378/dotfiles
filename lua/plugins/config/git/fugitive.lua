local M = {}

local map = require("utils").map

function M.config()
    map("n", "<leader>gs", ":G<CR>")
    map("n", "<leader>gl", ":diffget //3<CR>")
    map("n", "<leader>gh", ":diffget //2<CR>")
end

return M
