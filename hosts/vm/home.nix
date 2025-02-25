{
  config,
  lib,
  ...
}: {
  home.username = "bosse";
  home.homeDirectory = "/home/bosse";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./../../modules/user/cli.nix
    ./../../modules/user/firefox.nix
    ./../../modules/user/git.nix
    ./../../modules/user/hyprland.nix
    # ./../../modules/user/mpv.nix
    # ./../../modules/user/nautilus.nix
    # ./../../modules/user/nchat.nix
    ./../../modules/user/nvim.nix
    # ./../../modules/user/nyaa.nix
    # ./../../modules/user/obsidian.nix
    # ./../../modules/user/qmk.nix
    # ./../../modules/user/spotify.nix
    ./../../modules/user/term.nix
    ./../../modules/user/theme.nix
    ./../../modules/user/tmux.nix
    # ./../../modules/user/vesktop.nix
    ./../../modules/user/wallpaper.nix
    ./../../modules/user/waybar.nix
    ./../../modules/user/zsh.nix
  ];

  home.activation.drunScan = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${config.home.homeDirectory}/.dotfiles/scripts/drun-scan.sh
  '';

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    PAGER = "less";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  # Do not change these future me !
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
