return {
  {
    "ray-x/go.nvim",
    ft = { "go" },
    event = "VeryLazy",
    dependencies = {
      { "ray-x/guihua.lua" },
    },
    config = function()
      local utils = require "plugins.lsp.utils"

      require("go").setup {
        goimport = "gopls", -- if set to 'gopls' will use golsp format
        gofmt = "gopls", -- if set to gopls will use golsp format
        tag_transform = false,
        test_dir = "",
        comment_placeholder = "",
        lsp_cfg = {
          capabilities = utils.capabilities(),
        }, -- false: use your own lspconfig
        lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
        lsp_on_attach = utils.on_attach,
        dap_debug = true,
        lsp_inlay_hints = {
          enable = false,
        },
      }

      local keymap = vim.keymap.set

      keymap("n", "<leader>gc", ":lua require('go.comment').gen()<CR>")
      keymap("n", "<leader>ga", ":GoAlt<CR>")
      keymap("n", "<leader>gg", ":GoGenerate<CR>")
      keymap("n", "<leader>gd", ":GoDoc<CR>")
      keymap("n", "<leader>gt", ":GoTest<CR>")
      keymap("n", "<leader>gtf", ":GoTestFunc<CR>")

      -- Run gofmt + goimport on save
      local format_sync_grp = vim.api.nvim_create_augroup("format_sync", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimport()
        end,
        group = format_sync_grp,
      })
    end,
  },
}
