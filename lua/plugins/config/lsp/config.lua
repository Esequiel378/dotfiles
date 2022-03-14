local M = {}

local function on_attach(_, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

  buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("v", "<leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)

  buf_set_keymap("n", "sd", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
end

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_publish_diagnostics_options = {
  virtual_text = {
    prefix = "",
    spacing = 1,
  },
  signs = true,
  underline = true,
  -- update diagnostics insert mode
  update_in_insert = false,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  lsp_publish_diagnostics_options
)

function M.default_config()
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  }
end

return M
