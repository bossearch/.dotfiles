{ config, pkgs, ... }:
{
  home.packages = [ pkgs.zsh ];

  home.file.".config/.zshrc" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/.zshrc";
  };

  home.file.".zshenv" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/.zshenv";
  };
}
