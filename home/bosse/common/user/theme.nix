{
  config,
  pkgs,
  lib,
  ...
}: let
  papirusPath = "${pkgs.papirus-icon-theme}/share/icons/Papirus";
  iconSymlink = "${config.home.homeDirectory}/.local/share/icons/Papirus";
in {
  home.packages = with pkgs; [
    dconf
    papirus-icon-theme
    tokyonight-gtk-theme
  ];
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };

  xdg.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "kvantum";
  };

  home.file.".config/Kvantum" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/Kvantum";
    recursive = true;
  };

  home.activation.linkPapirusIcons = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ -d "${papirusPath}" ] && [ ! -e "${iconSymlink}" ]; then
      mkdir -p ${config.home.homeDirectory}/.local/share/icons
      ln -sf ${papirusPath} ${iconSymlink}
    fi
  '';
}
