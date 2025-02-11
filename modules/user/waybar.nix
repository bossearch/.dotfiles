{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs;
    [
      ddcutil
      dunst
      grim
      libnotify
      pavucontrol
      slurp
      socat
      tesseract
      waybar
      wl-screenrec
      wttrbar
    ]
    ++ [(pkgs.callPackage ./../custompkgs/sysboard.nix {})];

  home.file.".config/waybar" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/waybar";
    recursive = true;
  };

  home.file.".config/dunst" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/dunst";
    recursive = true;
  };
}
