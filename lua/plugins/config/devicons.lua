local M = {}

function M.setup(use)
    use {
        "kyazdani42/nvim-web-devicons",
        module = "nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup { default = true }
        end,
    }
end

return M
