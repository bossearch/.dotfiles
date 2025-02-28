return function(lspconfig, capabilities)
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
						expr = '(builtins.getFlake "/home/bosse/.dotfiles").nixosConfigurations.pc.options',
					},
					home_manager = {
						expr = '(builtins.getFlake "/home/bosse/.dotfiles").homeConfigurations."bosse@pc".options',
					},
				},
			},
		},
	})
end
