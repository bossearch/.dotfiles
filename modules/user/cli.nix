{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs; [
    bat
    bc
    btop-rocm
    curl
    eza
    fastfetch
    fd
    ffmpeg
    fzf
    git
    imagemagick
    jq
    killall
    lazygit
    oh-my-posh
    ouch
    poppler
    ripgrep
    tealdeer
    unzip
    wget
    zoxide
    ueberzugpp
    yazi
    mediainfo
  ];
  # ++ (with pkgs-unstable; [
  #   yazi
  # ]);

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

  home.file.".config/lazygit" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/lazygit";
    recursive = true;
  };

  home.file.".config/bat" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/bat";
    recursive = true;
  };

  home.file.".config/btop/btop.conf" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/btop/btop.conf";
  };
}
