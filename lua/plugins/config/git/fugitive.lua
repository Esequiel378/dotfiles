local map = require("utils").map

local M = {}

function M.config()
    map("n", "<leader>gs", ":G<CR>")
    map("n", "<leader>gl", ":diffget //3<CR>")
    map("n", "<leader>gh", ":diffget //2<CR>")
end

return M
