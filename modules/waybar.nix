{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    waybar
    dunst
    libnotify
    wttrbar
    ddcutil
    pavucontrol
    wvkbd
    socat
    grim
    slurp
    wl-screenrec
    tesseract
  ];

  home.file.".config/waybar" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/waybar";
    recursive = true;
  };

  home.file.".config/dunst" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/dunst";
    recursive = true;
  };
}
