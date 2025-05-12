{
  config,
  lib,
  outputs,
  ...
}: {
  imports =
    [
      ./cli
      ./git.nix
      ./nixpkgs.nix
      ./nvim.nix
      ./zsh.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  home = {
    username = "bosse";
    homeDirectory = "/home/bosse";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "less";
      BROWSER = "firefox";
      TERMINAL = "kitty";
    };
    activation.drunScan = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${config.home.homeDirectory}/.dotfiles/scripts/drun-scan.sh
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
