{
  config,
  pkgs,
  ...
}: {
  environment.sessionVariables = {
    EDITOR = "nvim";
    GDK_BACKEND = "wayland,x11";
    GSK_RENDERER = "gl";
    XDG_SESSION_TYPE = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    WLR_BACKEND = "vulkan";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    MOZ_ENABLE_WAYLAND = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    #   # Fix for some Java AWT applications (e.g. Android Studio),
    #   # use this if they aren't displayed properly:
    #   _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
