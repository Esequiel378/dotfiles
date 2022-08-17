local M = {}

M.setup = function(use)
	use {
		"williamboman/mason.nvim",
		config = M.config,
		requires = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"b0o/schemastore.nvim",
			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",
			"folke/lua-dev.nvim",
			"neovim/nvim-lspconfig",
		}
	}

	use {
		"SmiteshP/nvim-navic",
		module = { "nvim-navic" },
		requires = { "neovim/nvim-lspconfig" },
		config = function()
			require("nvim-navic").setup {}
		end,
	}

	use {
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup {}
		end,
	}
end

M.config = function()
	require("esequiel378.plugins.lsp.installer").config()
	require("esequiel378.plugins.lsp.handlers").config()
end

return M
