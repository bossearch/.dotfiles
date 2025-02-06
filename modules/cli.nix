{ config, pkgs, inputs, ... }:
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
    source = ./../configs/ohmypost.toml;
  };

  home.file.".config/fzf" = {
    source = ./../configs/fzf;
  };

  home.file.".config/yazi" = {
    source = ./../configs/yazi;
  };

  home.file.".config/fastfetch" = {
    source = ./../configs/fastfetch;
  };

  home.file.".config/btop" = {
    source = ./../configs/btop;
  };

  home.file.".config/bat" = {
    source = ./../configs/bat;
  };
}
