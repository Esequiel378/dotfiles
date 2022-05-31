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

    vim.cmd "packadd packer.nvim"
    present, packer = pcall(require, "packer")

    if present then
      print "Packer cloned successfully."
    else
      error("Couldn't clone packer !\nPacker path: " .. packer_path .. "\n" .. packer)
    end
  end

  vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"

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

  -- Performance
  pcall(require, "impatient")

  packer.init(conf)
  packer.startup(M.config)

  return packer
end

function M.config(use)
  use { "wbthomason/packer.nvim" }
  use { "nvim-lua/plenary.nvim", module = "plenary" }

  -- Copilot yay!
  use {
    "github/copilot.vim",
    config = function()
      local map = require("utils").map

      map("i", "<C-y>", 'copilot#Accept("")', { silent = true, script = true, expr = true })
      map("i", "<C-n>", "<Plug>(copilot-next)")
      map("i", "<C-p>", "<Plug>(copilot-previous)")
      vim.g.copilot_filetypes = { esl = false }
    end,
  }

  -- Performance
  use { "nathom/filetype.nvim" }
  use { "lewis6991/impatient.nvim" }

  -- TODO: Move plugins with configuration to it's own files
  use { "chr4/nginx.vim" }
  use { "tpope/vim-surround" }
  use { "andymass/vim-matchup" }
  use { "shmup/vim-sql-syntax" }
  use { "folke/lsp-colors.nvim" }
  use {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("colorizer").setup()
    end,
  }

  use { "tribela/vim-transparent" }

  use {
    "simrat39/symbols-outline.nvim",
    config = function()
      local map = require("utils").map
      map("n", "<leader>s", ":SymbolsOutline <CR>")

      require("symbols-outline").setup {
        auto_preview = false,
        position = "left",
        show_numbers = true,
        show_relative_numbers = true,
      }
    end,
  }

  -- Markdown
  use {
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview" },
  }
  -- END OF TODO!

  -- Notification
  require("plugins.config.notification").setup(use)

  -- Treesitter
  require("plugins.config.treesitter").setup(use)

  -- Telescope
  require("plugins.config.telescop").setup(use)

  -- Ranger
  require("plugins.config.ranger").setup(use)

  -- LSP
  require("plugins.config.lsp.init").setup(use)

  -- Completion
  require("plugins.config.cmp.init").setup(use)

  -- Statusline
  require("plugins.config.statusline").setup(use)

  -- Better icons
  require("plugins.config.devicons").setup(use)

  -- Better Comment
  require("plugins.config.comments").setup(use)

  -- Colorscheme
  require("plugins.config.colorscheme").setup(use)

  -- Startup screen
  require("plugins.config.startup_screen").setup(use)

  -- Git
  require("plugins.config.git.init").setup(use)

  -- Golang
  require("plugins.config.golang").setup(use)

  -- Trouble
  require("plugins.config.troubl").setup(use)

  -- Editorconfig
  require("plugins.config.editorconfig").setup(use)

  -- Debugging
  -- require("plugins.config.debugging.init").setup(use)

  if packer_bootstrap then
    print "Restart Neovim required after installation!"
    require("packer").sync()
  end
end

return M
