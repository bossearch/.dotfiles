{
  config,
  pkgs,
  ...
}: {
  services = {
    blueman.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
  };
}
