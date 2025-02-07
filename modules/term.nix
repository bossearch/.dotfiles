{ config, pkgs, lib, ... }:

{
  home.file.".config/alacritty/alacritty.toml".source = ./../configs/alacritty/alacritty.toml;
  home.file.".config/alacritty/tokyonight.toml".source = ./../configs/alacritty/tokyonight.toml;
}
