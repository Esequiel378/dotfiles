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
    packer_bootstrap = vim.fn.system {
      "git",
      "clone",
      "https://github.com/wbthomason/packer.nvim",
      "--depth",
      "20",
      packer_path,
    }

    vim.cmd [[packadd packer.nvim]]
    present, packer = pcall(require, "packer")

    if present then
      print "Packer cloned successfully."
    else
      error("Couldn't clone packer !\nPacker path: " .. packer_path .. "\n" .. packer)
    end
  end

  vim.cmd "autocmd BufWritePost plugins.init.lua source <afile> | PackerCompile"

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

  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  }

  -- Lua
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  }

  -- Copilot yay!
  use {
    "github/copilot.vim",
    config = function()
      local map = require("core.utils").map

      map("i", "<C-y>", 'copilot#Accept("")', { silent = true, script = true, expr = true })
      map("i", "<C-n>", "<Plug>(copilot-next)")
      map("i", "<C-p>", "<Plug>(copilot-previous)")
      vim.g.copilot_filetypes = { esl = false }
    end,
  }

  require("plugins.config.ui-ux").setup(use)
  require("plugins.config.git").setup(use)
  require("plugins.config.ranger").setup(use)
  require("plugins.config.trouble").setup(use)
  require("plugins.config.editorconfig").setup(use)
  require("plugins.config.telescope").setup(use)
  require("plugins.config.lsp").setup(use)
  require("plugins.config.cmp").setup(use)
  require("plugins.config.statusline").setup(use)
  require("plugins.config.golang").setup(use)
  require("plugins.config.dap").setup(use)

  if packer_bootstrap then
    print "Restart Neovim required after installation!"
    require("packer").sync()
  end
end

return M
