{
  pkgs,
  ...
}: {
  imports = [
    ./bat
    ./btop
    ./buku
    ./fastfetch
    ./fzf
    ./lazygit
    ./tealdeer
    # ./uair
    ./yazi
  ];
  home.packages = with pkgs;
    [
      bc
      curl
      eza
      fd
      ffmpeg
      fzf
      imagemagick
      jq
      killall
      ouch
      poppler
      ripgrep
      toipe
      unzip
      wget
      zoxide
      moreutils
      mediainfo
    ];
}
