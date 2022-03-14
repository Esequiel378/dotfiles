local config = require("plugins.config.lsp.config")
local M = {}

function M.setup(use)
    use {
        "neovim/nvim-lspconfig",
        opt = true,
        event = "BufReadPre",
        wants = { "nvim-lsp-installer" },
        config = function()
            require("plugins.config.lsp").config()
        end,
        requires = {
            "williamboman/nvim-lsp-installer",
        },
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

    local opts = config.default_config()

    require("plugins.config.lsp.installer").setup(servers, opts)
end

return M
