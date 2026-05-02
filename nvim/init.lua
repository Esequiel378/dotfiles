-- [[ Load Custom Configurations ]]
require "option"  -- Options and settings
require "autocmd" -- Autocommands
require "keymaps" -- Keymaps

-- [[ Install Lazy.nvim if Not Installed ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- [[ Remove Built-in Plugins ]]
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "matchit",
  "matchparen",
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
}

for _, plugin in ipairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

-- [[ Configure Plugins with Lazy.nvim ]]
require("lazy").setup({
  { import = "plugins" }, -- Load plugins from a dedicated `plugins` folder
})
