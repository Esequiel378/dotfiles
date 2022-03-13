local M = {}

function M.setup(use)
    use {
        "tpope/vim-fugitive",
        setup = function()
            require("plugins.config.git.fugitive").setup()
        end,
    }
    -- use {
    --     "lewis6991/gitsigns.nvim",
    --     config = function() require "plugins.configs.gitsigns" end,
    --     setup = function()
    --         require("core.utils").packer_lazy_load "gitsigns.nvim"
    --     end,
    -- }
end

return M
