{ config, pkgs, ... }:

{
  # Install CLI tools system-wide
  home.packages = with pkgs; [
    git
    curl
    wget
    fzf
    zoxide
    bat
    eza
    oh-my-posh
    btop-rocm
    fastfetch
    yazi
    tmux
    tealdeer
    jq
    bc
  ];

  home.file.".config/yazi" = {
    source = ./../configs/yazi;
  };

  home.file.".config/ohmypost.toml" = {
    source = ./../configs/ohmypost.toml;
  };

  home.file.".config/fzf" = {
    source = ./../configs/fzf;
  };
}
