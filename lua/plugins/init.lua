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

    packer.init(conf)
    packer.startup(M.config)

    return packer
end

function M.config(use)
    use { "wbthomason/packer.nvim" }

    -- Markdown
    use {
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      ft = "markdown",
      cmd = { "MarkdownPreview" },
    }

    -- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- Treesitter
    require("plugins.config.treesitter").setup(use)

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

    if packer_bootstrap then
        print "Restart Neovim required after installation!"
        require("packer").sync()
    end
end

return M
