{pkgs, ...}: {
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland >/dev/null";
        user = "bosse";
      };
      default_session = initial_session;
    };
  };
}
