{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    mpv
    vapoursynth
    yt-dlp
  ];

  # hardware.keyboard.qmk.enable = false;

  home.file.".config/mpv" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/mpv";
    recursive = true;
  };
}
