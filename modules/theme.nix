{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    dconf  # Required for GTK settings
    papirus-icon-theme
    tokyonight-gtk-theme
  ];
  home.pointerCursor = {
    name = "Adwaita";  # Adwaita cursor theme
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
      name = "Papirus-Dark";  # Set Papirus Dark (or "Papirus" for light version)
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";  # Make Qt follow GTK theme
    style = {
      name = "tokyonight";  # Qt theme to match GTK
      package = pkgs.tokyonight-gtk-theme;
    };
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gtk2";  # Makes Qt use the GTK theme
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };
}
