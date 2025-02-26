return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		{
			"folke/lazydev.nvim",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("blink.cmp").get_lsp_capabilities()

    require("plugins.lsp.lua_ls")(lspconfig, capabilities)
    require("plugins.lsp.clangd")(lspconfig, capabilities)
    require("plugins.lsp.bashls")(lspconfig, capabilities)
    require("plugins.lsp.nixd")(lspconfig, capabilities)

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			vim.lsp.buf.format({
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (in visual mode)" })

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end
	end,
}
