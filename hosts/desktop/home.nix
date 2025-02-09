{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.username = "bosse";
  home.homeDirectory = "/home/bosse";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  imports = [
    ./../../modules/git.nix
    ./../../modules/cli.nix
    ./../../modules/qmk.nix
    ./../../modules/mpv.nix
    ./../../modules/zsh.nix
    ./../../modules/nyaa.nix
    ./../../modules/nvim.nix
    ./../../modules/term.nix
    ./../../modules/tmux.nix
    ./../../modules/nchat.nix
    ./../../modules/theme.nix
    ./../../modules/waybar.nix
    ./../../modules/spotify.nix
    ./../../modules/vesktop.nix
    ./../../modules/firefox.nix
    ./../../modules/hyprland.nix
    ./../../modules/wallpaper.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
