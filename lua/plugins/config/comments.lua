local M = {}

function M.setup(use)
    use {
        "numToStr/Comment.nvim",
        opt = true,
        keys = { "gc", "gcc", "gbc" },
        config = function()
            require("Comment").setup()
        end,
    }
end

return M
