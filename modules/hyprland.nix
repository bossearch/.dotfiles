{config, pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    # Whether to enable Hyprland wayland compositor
    enable = true;
    # The hyprland package to use
    package = pkgs.hyprland;
    # Whether to enable XWayland
    xwayland.enable = true;
    settings = { };
  };

  services.hypridle.enable = true;

  home.packages = with pkgs; [
    hyprpaper
    hyprlock
    hypridle
    hyprsunset
    hyprpicker
    cliphist
    wl-clipboard
    zenity
  ];

  # home.activation.copyAlacritty = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   rm -rf ~/.config/hypr
  #   cp -r ${./../configs/hypr} ~/.config/hypr
  # '';

  home.file.".config/hypr" = {
    source = ./../configs/hypr;
  };
}
