{...}: {
  imports = [
    ./common/core
    ./common/optional/browser.nix
    ./common/optional/gowall.nix
    ./common/optional/hyprland
    # ./common/optional/kdeconnect.nix
    ./common/optional/kitty.nix
    # ./common/optional/minecraft.nix
    # ./common/optional/mpv.nix
    ./common/optional/nautilus.nix
    # ./common/optional/nchat.nix
    # ./common/optional/neomutt.nix
    # ./common/optional/newsboat.nix
    # ./common/optional/nyaa.nix
    # ./common/optional/obsidian.nix
    # ./common/optional/qmk.nix
    # ./common/optional/spotify.nix
    ./common/optional/theme.nix
    # ./common/optional/vesktop.nix
    ./common/optional/waybar
  ];

  monitors = [
    {
      name = "Virtual-1";
      width = 1920;
      height = 1080;
      refreshRate = 60;
      primary = true;
    }
  ];

  # Do not change these future me !
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
