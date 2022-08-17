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

	-- TODO: Check if it makes sence to recompile the file on save (since M.config won't be called)
	-- vim.cmd "autocmd BufWritePost *.lua source <afile> | PackerCompile"
	-- vim.cmd "autocmd BufWritePost esequiel378.packer source <afile> | PackerCompile"

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

	-- extend vim's builtins
	use { "tpope/vim-surround" }
	use { "andymass/vim-matchup" }

	-- colors
	use { "folke/lsp-colors.nvim" }
	use {
		"shmup/vim-sql-syntax",
		ft = "sql",
	}
	use {
		"mechatroner/rainbow_csv",
		ft = "csv",
	}
	use {
		"norcalli/nvim-colorizer.lua",
		event = "BufRead",
		config = function()
			require("colorizer").setup()
		end,
	}

	use {
		"bluz71/vim-moonfly-colors",
		config = function()
			vim.cmd [[colorscheme moonfly]]
			-- vim.cmd "hi Normal guibg=0000"
		end,
	}

	use {
		"tpope/vim-commentary",
		keys = { "gc", "gcc", "gbc" },
	}

	use {
		"rcarriga/nvim-notify",
		event = "VimEnter",
		config = function()
			vim.notify = require "notify"

			require("notify").setup {
				background_colour = "#000000",
			}
		end,
	}


	require("esequiel378.plugins.treesitter").setup(use)
	require("esequiel378.plugins.alpha-nvim").setup(use)
	require("esequiel378.plugins.editorconfig").setup(use)
	require("esequiel378.plugins.trouble").setup(use)
	require("esequiel378.plugins.telescope").setup(use)
	require("esequiel378.plugins.git.init").setup(use)
	require("esequiel378.plugins.lsp.init").setup(use)

	if packer_bootstrap then
		print "Restart Neovim required after installation!"
		require("packer").sync()
	end
end

return M
