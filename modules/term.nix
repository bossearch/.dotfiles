{ config, pkgs, mkMutableSymlink, lib, ... }:

{
  home.file.".config/alacritty" = {
    source = ./../configs/alacritty;
  };

  home.file.".config/tmux" = {
    source = ./../configs/tmux;
  };
}
