{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.hyprland.enable = true;
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  services = lib.mkMerge [
    {
      blueman.enable = true;
      gvfs = {
        enable = true;
        package = pkgs.gnome.gvfs;
      };
      udisks2 = {
        enable = true;
        package = pkgs.udisks2;
      };
    }
    (lib.mkIf (config.networking.hostName == "vm") {
      spice-vdagentd.enable = true;
      qemuGuest.enable = true;
    })
  ];
}
