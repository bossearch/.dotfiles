{pkgs, ...}: {
  home.packages = with pkgs; [
    nautilus
    sushi
    vaults
  ];
  dconf.settings = {
    "org/gnome/desktop/privacy" = {
      remember-recent-files = false;
    };
  };
}
