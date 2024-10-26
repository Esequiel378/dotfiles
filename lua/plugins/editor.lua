return {
	"tpope/vim-sleuth",
	{ "kylechui/nvim-surround", event = "VeryLazy" },
	{ "tpope/vim-surround", event = "VeryLazy" },
	{ "tpope/vim-sleuth", event = "VeryLazy" },
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{
		"editorconfig/editorconfig-vim",
		lazy = false,
		config = function()
			vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*" }
			vim.api.nvim_del_user_command("EditorConfigEnable")
			vim.api.nvim_del_user_command("EditorConfigReload")
			vim.api.nvim_del_user_command("EditorConfigDisable")
		end,
	},
	{
		"andymass/vim-matchup",
		lazy = false,
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	{
		"numToStr/Comment.nvim",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		keys = {
			{ "gc", mode = { "n", "v" } },
			{ "gcc", mode = { "n", "v" } },
			{ "gbc", mode = { "n", "v" } },
		},
		config = function(_, _)
			local opts = {
				ignore = "^$",
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			}
			require("Comment").setup(opts)
		end,
	},
	{
		"github/copilot.vim",
		event = "VeryLazy",
		cmd = "Copilot",
		keys = {
			-- { "<C-y>", mode = { "i" }, "<Plug>(copilot-accept)", desc = "Accept Copilot suggestion" },
			{ "<C-n>", mode = { "i" }, "<Plug>(copilot-next)", desc = "Next Copilot suggestion" },
			{ "<C-p>", mode = { "i" }, "<Plug>(copilot-previous)", desc = "Previous Copilot suggestion" },
			{ "<C-e>", mode = { "i" }, "<Plug>(copilot-dismiss)", desc = "Dismiss Copilot suggestion" },
		},
	},
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit", "G" },
		keys = {
			{ "<leader>gs", "<cmd>:G<CR><C-w>T", desc = "Git Status" },
		},
	},
}
