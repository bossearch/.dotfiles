{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    qmk
  ];

  # hardware.keyboard.qmk.enable = false;

  home.file.".config/qmk" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/qmk";
    recursive = true;
  };
}
