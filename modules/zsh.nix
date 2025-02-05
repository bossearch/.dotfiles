{ config, pkgs, ... }:

{
  home.packages = [ pkgs.zsh ];

  home.file.".config/zsh/.zshrc" = {
    source = ./../configs/zsh/.zshrc;
  };

  home.file.".zshenv" = {
    source = ./../configs/zsh/.zshenv;
  };
}
