local M = {}

-- Indicate first time installation
local packer_bootstrap = false

function M.setup()
  local present, packer = pcall(require, "packer")

  if not present then
    local packer_path = vim.fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"

    print "Cloning packer..."

    -- remove the dir before cloning
    vim.fn.delete(packer_path, "rf")
    vim.fn.system {
      "git",
      "clone",
      "https://github.com/wbthomason/packer.nvim",
      "--depth",
      "20",
      packer_path,
    }

    packer_bootstrap = true

    vim.cmd [[packadd packer.nvim]]
    present, packer = pcall(require, "packer")

    if present then
      print "Packer cloned successfully."
    else
      error("Couldn't clone packer !\nPacker path: " .. packer_path .. "\n" .. packer)
    end
  end

  -- packer.nvim configuration
  local conf = {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "single" }
      end,
      prompt_border = "single",
    },
    profile = {
      enable = true,
      threshold = 0,
    },
  }

  packer.init(conf)
  packer.startup(M.config)

  return packer
end

function M.config(use)
  -- Performance
  use {
    "lewis6991/impatient.nvim",
    config = function()
      require "impatient"
    end,
  }
  use { "nathom/filetype.nvim" }

  use { "wbthomason/packer.nvim" }
  use { "nvim-lua/plenary.nvim", module = "plenary" }

  require("esequiel378.plugins.common").setup(use)
  require("esequiel378.plugins.treesitter").setup(use)
  require("esequiel378.plugins.alpha-nvim").setup(use)
  require("esequiel378.plugins.editorconfig").setup(use)
  require("esequiel378.plugins.trouble").setup(use)
  require("esequiel378.plugins.telescope").setup(use)
  require("esequiel378.plugins.git.init").setup(use)
  require("esequiel378.plugins.lsp.init").setup(use)
  require("esequiel378.plugins.cmp").setup(use)
  require("esequiel378.plugins.cht-sh").setup(use)
  require("esequiel378.plugins.statusline").setup(use)
  require("esequiel378.plugins.ranger").setup(use)
  require("esequiel378.plugins.go").setup(use)
  require("esequiel378.plugins.dbg").setup(use)

  if packer_bootstrap then
    print "Restart Neovim required after installation!"
    require("packer").sync()
  end
end

return M
