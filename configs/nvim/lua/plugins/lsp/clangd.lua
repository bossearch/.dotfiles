return function(lspconfig, capabilities)
	lspconfig.clangd.setup({
		capabilities = capabilities,
		settings = {
			formatting = {
				command = { "clang-format" },
			},
		},
	})
end
