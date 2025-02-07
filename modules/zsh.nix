{ config, pkgs, ... }:
{
  home.packages = [ pkgs.zsh ];

  home.file.".config/zsh/.zshrc" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/zsh/.zshrc";
    recursive = true;
  };

  home.file.".zshenv" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/zsh/.zshenv";
    recursive = true;
  };
}
