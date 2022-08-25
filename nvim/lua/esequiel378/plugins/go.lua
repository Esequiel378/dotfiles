local M = {}

M.setup = function(use)
  use {
    "ray-x/go.nvim",
    ft = { "go" },
    requires = {
      "ray-x/guihua.lua",
    },
    config = M.config,
  }
end

M.config = function()
  local opts = require("esequiel378.plugins.lsp.installer").default_config()

  -- 
  require("go").setup {
    goimport = "gopls", -- if set to 'gopls' will use golsp format
    gofmt = "gopls", -- if set to gopls will use golsp format
    tag_transform = false,
    test_dir = "",
    comment_placeholder = "- ",
    lsp_cfg = {
      capabilities = opts.capabilities,
    }, -- false: use your own lspconfig
    lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
    lsp_on_attach = opts.on_attach,
    dap_debug = true,
    lsp_inlay_hints = {
      enable = false,
    },
  }

  -- Run gofmt + goimport on save
  vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
  vim.cmd "autocmd FileType go nmap <Leader>gc :lua require('go.comment').gen()<CR>"
end

return M
