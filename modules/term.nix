{ config, pkgs, lib, ... }:
{
  home.file.".config/alacritty" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/alacritty";
    recursive = true;
  };
}
