-- Install lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup {
  spec = {
    { import = "plugins" },
    { import = "plugins.extras.lang" },
    { import = "plugins.extras.ui" },
    { import = "plugins.extras.pde" },
  },
  defaults = { lazy = true, version = nil },
  install = { missing = true, colorscheme = { "tokyonight", "gruvbox" } },
  checker = { enabled = true },
  change_detection = {
    notify = false,
  },
  -- Disable some builtin vim plugins
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "matchit",
        "matchparen",
        "netrw",
        "netrwFileHandlers",
        "netrwPlugin",
        "netrwSettings",
        "rrhelper",
        "spellfile_plugin",
        "tar",
        "tarPlugin",
        "tohtml",
        "tutor",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
      },
    },
  },
}

vim.keymap.set("n", "<leader>z", "<cmd>:Lazy<CR>", { desc = "Plugin Manager" })
