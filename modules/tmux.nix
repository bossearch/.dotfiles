{ config, pkgs, ... }:
{
  # programs.tmux = {
  #   enable = true;
  # };
  #
  home.packages = with pkgs; [
    tmux
  ];
  home.file.".config/tmux/tmux.conf".source = ./../configs/tmux/tmux.conf;
}

