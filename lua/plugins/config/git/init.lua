local M = {}

function M.setup(use)
    use {
        "tpope/vim-fugitive",
        keys = {" gs"},
        config = function()
            require("plugins.config.git.fugitive").config()
        end,
    }
    use {
        "lewis6991/gitsigns.nvim",
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require("plugins.config.git.signs").config()
        end,
    }
end

return M
