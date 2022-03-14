local M = {}

function M.setup(use)
    use {
        "neovim/nvim-lspconfig",
        opt = true,
        event = "BufReadPre",
        wants = { "nvim-lsp-installer" },
        requires = {
            "williamboman/nvim-lsp-installer",
        },
        config = function()
            require("plugins.config.lsp").config()
        end,
    }
end

function M.config()
    local servers = {
        gopls = {},
        html = {},
        jsonls = {},
        pyright = {},
        sumneko_lua = {},
        tsserver = {},
        vimls = {},
    }

    local opts = require("plugins.config.lsp.config").default_config()

    require("plugins.config.lsp.installer").setup(servers, opts)
end

return M
