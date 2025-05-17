{pkgs, ...}: {
  imports = [
    ./blink-cmp.nix
    # ./colorful-winsep.nix
    ./highlight-colors.nix
    ./lazydev.nix
    ./lualine.nix
    ./luasnip.nix
    ./lsp.nix
    ./lz-n.nix
    ./mini.nix
    ./noice.nix
    ./oil.nix
    ./snacks.nix
    ./telescope.nix
    ./tmux-navigator.nix
    ./todo-comments.nix
    ./tokyonight.nix
    ./treesitter.nix
    ./which-key.nix
    # TODO: Do i need trouble, treesj, substitute, gitsigns
  ];

  programs.nixvim = {
    # NOTE: Not work when performance.combinePlugins is enabled
    # extraPlugins = let
    #   colorful-winsep = pkgs.vimUtils.buildVimPlugin {
    #     name = "colorful-winsep";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "nvim-zh";
    #       repo = "colorful-winsep.nvim";
    #       rev = "7bbe4e1353c0fe37c98bad2758aafc410280f6b3";
    #       sha256 = "sha256-3ZXbpUNZqLHaUWgb2wHnfQfcGkMpcRtAt8q7z0tmo1o=";
    #     };
    #   };
    # in [
    #   colorful-winsep
    # ];
    performance.combinePlugins = {
      enable = true;
      pathsToLink = ["/plugins"];
      standalonePlugins = [
        "blink.cmp"
        "oil.nvim"
        "nvim-treesitter"
      ];
    };
  };
}
