{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    dconf
    papirus-icon-theme
    tokyonight-gtk-theme
    libsForQt5.qtstyleplugin-kvantum
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
    platformTheme.name = "gtk";
    style.name = "kvantum";
  };

  home.file.".config/Kvantum" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/Kvantum";
    recursive = true;
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gtk2";
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };
}
