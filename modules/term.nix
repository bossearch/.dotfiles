{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    (pkgs.callPackage ./custompkgs/alacritty.nix {})
  ];

  home.file.".config/alacritty" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/alacritty";
    recursive = true;
  };
}
