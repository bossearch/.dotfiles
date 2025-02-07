{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    tmux
  ];
  home.file.".config/tmux" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/tmux";
    recursive = true;
  };
}

