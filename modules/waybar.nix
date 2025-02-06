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
    source = ./../configs/waybar;
  };

  home.file.".config/dunst" = {
    source = ./../configs/dunst;
  };
}
