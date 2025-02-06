{ config, pkgs, mkMutableSymlink, lib, ... }:

{
  home.file.".config/alacritty" = {
    source = ./../configs/alacritty;
  };
}
