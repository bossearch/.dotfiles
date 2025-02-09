{ config, pkgs, ... }:
let
  my-mpv-unwrapped = pkgs.mpv-unwrapped.override {
    vapoursynthSupport = true;
  };
in
{
  home.packages = with pkgs; [
    vapoursynth-mvtools
    yt-dlp
  ];

  programs.mpv = {
    enable = true;
    package = pkgs.mpv.override {
      mpv = my-mpv-unwrapped;
      extraMakeWrapperArgs = [
        "--prefix" "LUA_PATH" ";" "${pkgs.lua52Packages.dkjson}/share/lua/5.2/?.lua"
      ];
    };
  };

  home.file.".config/mpv" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/mpv";
    recursive = true;
  };
}
