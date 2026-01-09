return {
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
		opts = {},
		config = function(_, _)
			require("go").setup({
				goimports = "goimports",
				gofmt = "gofumpt",
				comment_placeholder = "",
				lsp_keymaps = false,
				dap_debug = true,
				lsp_codelens = true,
				lsp_inlay_hints = {
					enable = false,
				},
			})

			-- Run gofmt + goimport on save
			local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = "*.go",
				callback = function()
					require("go.format").gofmt()
					require("go.format").goimport()
				end,
				group = format_sync_grp,
			})
		end,
	},
	{
		"rafaelsq/nvim-goc.lua",
		event = "VeryLazy",
		-- stylua: ignore
		keys = {
			{ "<leader>gcr", function() require("nvim-goc").Coverage() end,      desc = "Go Coverage", },
			{ "<leader>gcc", function() require("nvim-goc").ClearCoverage() end, desc = "Go Clear Coverage", },
			{ "<leader>gct", function() require("nvim-goc").CoverageFunc() end,  desc = "Go Coverage Function", },
			{ "<leader>gcf", function() require("nvim-goc").Coverage() end,  desc = "Go Coverage File", },
			{ "<leader>ga", function() require("nvim-goc").Alternate() end,      desc = "Go Coverage", },
		},
		config = function()
			-- if set, when we switch between buffers, it will not split more than once. It will switch to the existing buffer instead
			vim.opt.switchbuf = "useopen"

			require("nvim-goc").setup({
				verticalSplit = false,
			})
		end,
	},
}
