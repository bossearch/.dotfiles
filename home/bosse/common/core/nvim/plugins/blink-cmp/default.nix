{pkgs, ...}: {
  programs.nixvim = {
    extraPackages = with pkgs; [
      wordnet
    ];
    plugins = {
      blink-cmp-dictionary.enable = true;
      # blink-cmp-git.enable = true;
      blink-cmp-spell.enable = true;
      blink-copilot.enable = true;
      blink-ripgrep.enable = true;
      blink-cmp = {
        enable = true;
        setupLspCapabilities = true;
        settings = {
          keymap = {
            preset = "super-tab";
          };
          snippets = {
            preset = "luasnip";
          };
          signature = {
            enabled = true;
            window = {
              border = "rounded";
            };
          };
          appearance = import ./appearance.nix;
          sources = import ./sources.nix;
          completion = import ./completion.nix;
        };
      };
    };
  };
}
