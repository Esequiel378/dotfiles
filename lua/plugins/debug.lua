return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		-- Required dependency for nvim-dap-ui
		"nvim-neotest/nvim-nio",

		-- Installs the debug adapters for you
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",

		-- Add your own debuggers here
		"leoluz/nvim-dap-go",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		require("nvim-dap-virtual-text").setup({})
		vim.g.dap_virtual_text = true

		require("mason-nvim-dap").setup({
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				"delve",
			},
		})

		local dap = require("dap")
		local dapui = require("dapui")

		vim.keymap.set("n", "<F1>", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F2>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F3>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F4>", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>gb", dap.run_to_cursor, { desc = "Debug: Run To Cursor" })
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>?", function()
			require("dapui").eval(nil)
		end, { desc = "Debug: Eval Under Cursor" })
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Set Breakpoint" })

		-- Dap UI setup
		dapui.setup()

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- Install golang specific config
		require("dap-go").setup({
			delve = {
				-- On Windows delve must be run attached or it crashes.
				-- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
				detached = true,
			},
		})
	end,
}
