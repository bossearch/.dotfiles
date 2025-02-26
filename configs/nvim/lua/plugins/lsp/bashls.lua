return function(lspconfig, capabilities)
	lspconfig.bashls.setup({
		capabilities = capabilities,
		settings = {
			formatting = {
				command = { "shfmt" },
			},
		},
	})
end
