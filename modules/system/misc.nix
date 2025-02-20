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
      fstrim.enable = true;
      blueman.enable = true;
      gvfs = {
        enable = true;
        package = pkgs.gnome.gvfs;
      };
      udisks2 = {
        enable = true;
        package = pkgs.udisks2;
        mountOnMedia = true;
      };
    }
    (lib.mkIf (config.networking.hostName == "vm") {
      spice-vdagentd.enable = true;
      qemuGuest.enable = true;
    })
  ];

  # Ensure /media exists with the correct permissions
  systemd.tmpfiles.rules = [
    "d /media 0755 root root -"
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
}
