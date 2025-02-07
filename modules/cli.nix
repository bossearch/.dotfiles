{ config, pkgs, inputs, ... }:
{
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
    tealdeer
    jq
    bc
    fd
    ffmpeg
    ripgrep
    poppler
    ouch
    lazygit
    unzip
    imagemagick
  ] ++ (with inputs.nixpkgs-unstable.legacyPackages.x86_64-linux; [
    yazi
  ]);

  home.file.".config/ohmypost.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/ohmypost.toml";
  };

  home.file.".config/fzf" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/fzf";
    recursive = true;
  };

  home.file.".config/yazi" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/yazi";
    recursive = true;
  };

  home.file.".config/fastfetch" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/fastfetch";
    recursive = true;
  };

  home.file.".config/btop" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/btop";
    recursive = true;
  };

  home.file.".config/bat" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/bat";
    recursive = true;
  };
}
