{
  config,
  lib,
  ...
}: {
  services =
    {
      blueman.enable = true;
      gvfs.enable = true;
      udisks2.enable = true;
    }
    // (lib.mkIf (config.networking.hostName == "vm") {
      spice-vdagentd.enable = true; # Enable copy/paste in VM
      qemuGuest.enable = true;
    });
}
