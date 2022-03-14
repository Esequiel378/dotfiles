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
        goimport = 'gopls', -- if set to 'gopls' will use golsp format
        gofmt = 'gopls', -- if set to gopls will use golsp format
        max_line_len = 120,
        tag_transform = false,
        test_dir = '',
        comment_placeholder = '   ',
        lsp_cfg = {
          capabilities = opts.capabilities,
        }, -- false: use your own lspconfig
        lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
        lsp_on_attach = opts.on_attach, -- use on_attach from go.nvim
        dap_debug = true,
    })

    -- Run gofmt + goimport on save
    vim.api.nvim_exec([[
        autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
    ]], false)

    vim.cmd("autocmd FileType go nmap <Leader>gc :lua require('go.comment').gen()")
end

return M
