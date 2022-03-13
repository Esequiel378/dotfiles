local M = {}

function M.setup(use)
    use {
        "gruvbox-community/gruvbox",
        config = function()
            vim.o.background = "dark" -- or "light" for light mode
            vim.g.gruvbox_invert_selection = 0
            vim.cmd "colorscheme gruvbox"
        end,
    }

    use {
        "bluz71/vim-moonfly-colors",
        disable = true,
        config = function()
            vim.cmd "colorscheme moonfly"
        end,
    }
end

return M
