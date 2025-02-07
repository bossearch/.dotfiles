{config, pkgs, lib, ... }:
{
  # wayland.windowManager.hyprland = {
  #   # Whether to enable Hyprland wayland compositor
  #   enable = true;
  #   # The hyprland package to use
  #   package = pkgs.hyprland;
  #   # Whether to enable XWayland
  #   xwayland.enable = true;
  #   settings = { };
  # };
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

  services.hypridle.enable = true;

  home.file.".config/hypr" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/hypr";
    recursive = true;
  };
}
