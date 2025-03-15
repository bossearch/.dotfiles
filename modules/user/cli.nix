{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: let
  bat_cache= "${config.home.homeDirectory}/.cache/bat";
  tealdeer_cache = "${config.home.homeDirectory}/.cache/tealdeer";
  bukubrow_file = "${config.home.homeDirectory}/.mozilla/native-messaging-hosts/com.samhh.bukubrow.json";
in {
  home.packages = with pkgs; [
    bat
    bc
    buku
    bukubrow
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
    ouch
    poppler
    ripgrep
    tealdeer
    toipe
    uair
    unzip
    wget
    zoxide
    moreutils
    mediainfo
  ]
  ++ (with pkgs-unstable; [
    yazi
  ]);

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

  home.file.".local/share/buku" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/buku";
    recursive = true;
  };

  home.file.".config/btop/btop.conf" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/btop/btop.conf";
  };

  home.file.".config/uair/uair.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/uair/uair.toml";
  };

  home.activation.updatebat = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -d "${bat_cache}" ];  then
      ${pkgs.bat}/bin/bat cache --build
    fi
  '';

  home.activation.updatetldr = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -d "${tealdeer_cache}" ];  then
      ${pkgs.tealdeer}/bin/tldr --update
    fi
  '';

  home.activation.bukubrow = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -f "${bukubrow_file}" ];  then
      ${pkgs.buku}/bin/buku -k
      ${pkgs.bukubrow}/bin/bukubrow --install-firefox
    fi
  '';
}
