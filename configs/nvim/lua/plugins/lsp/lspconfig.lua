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

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				formatting = {
					command = { "stylua" },
				},
			},
		})

		lspconfig.clangd.setup({
			capabilities = capabilities,
			settings = {
				formatting = {
					command = { "clang-format" },
				},
			},
		})

		lspconfig.nixd.setup({
			capabilities = capabilities,
			cmd = { "nixd" },
			settings = {
				nixd = {
					nixpkgs = {
						expr = "import <nixpkgs> { }",
					},
					formatting = {
						command = { "alejandra" },
					},
					options = {
						nixos = {
							expr = '(builtins.getFlake "/home/bosse/.dotfiles").nixosConfigurations.desktop.options',
						},
						home_manager = {
							expr = '(builtins.getFlake "/home/bosse/.dotfiles").homeConfigurations."bosse@desktop".options',
						},
					},
				},
			},
		})
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end
	end,
}
