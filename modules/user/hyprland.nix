{
  config,
  pkgs,
  lib,
  hostName,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    settings = lib.mkMerge [
      (lib.mkIf hostName.desktop {
        monitor = ["DP-3, 2560x1440@165, 0x0, 1"];
      })
      (lib.mkIf hostName.vm {
        monitor = ["Virtual-1, 1920x1080@165, 0x0, 1"];
      })
    ];
    extraConfig = ''
      # AUTOSTART
      source = ~/.config/hypr/conf/autostart.conf

      # ENVIRONMENT
      source = ~/.config/hypr/conf/environtment.conf

      # GENERAL
      source = ~/.config/hypr/conf/general.conf

      # DECORATION AND BLUR
      source = ~/.config/hypr/conf/decoration.conf

      # ANIMATIONS
      source = ~/.config/hypr/conf/animations.conf

      # LAYOUT
      source = ~/.config/hypr/conf/layout.conf

      # MISC
      source = ~/.config/hypr/conf/misc.conf

      # INPUT
      source = ~/.config/hypr/conf/input.conf

      # KEYBINDINGS
      source = ~/.config/hypr/conf/keybindings.conf

      # WINDOWS AND WORKSPACES
      source = ~/.config/hypr/conf/windowrule.conf

      # PLUGINS
      source = ~/.config/hypr/conf/plugin.conf
    '';
  };

  home.packages = with pkgs; [
    cliphist
    hypridle
    hyprlock
    hyprpaper
    hyprpicker
    hyprsunset
    wl-clipboard
    xdg-desktop-portal-hyprland
    zenity
  ];

  services.hypridle.enable = true;

  home.file.".config/hypr/conf" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/hypr/conf";
    recursive = true;
  };

  home.file.".config/hypr/scripts" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/hypr/scripts";
    recursive = true;
  };

  home.file.".config/hypr/colors.conf" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/hypr/colors.conf";
  };

  home.file.".config/hypr/hypridle.conf" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/hypr/hypridle.conf";
  };

  home.file.".config/hypr/hyprlock.conf" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/hypr/hyprlock.conf";
  };

  home.file.".config/hypr/hyprpaper.conf" = lib.mkMerge [
    (lib.mkIf hostName.desktop {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/hypr/hyprpaper.conf";
    })
    (lib.mkIf hostName.vm {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/hypr/hyprpaper-vm.conf";
    })
  ];
}
