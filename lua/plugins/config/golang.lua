local M = {}

function M.setup(use)
    use {
        "ray-x/go.nvim",
        ft = { "go" },
        config = function()
            require("plugins.config.golang").config()
        end,
    }
end

function M.config()
    local opts = require("plugins.config.lsp.config").default_config()

    require("go").setup({
        lsp_cfg = {
            capabilities = opts.capabilities,
        },
    })

    -- Run gofmt + goimport on save
    vim.api.nvim_exec([[
        autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
    ]], false)
end

return M
