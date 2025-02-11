{
  config,
  pkgs,
  ...
}: {
  # Use systemd bootload
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";

  ## grub bootleader
  # boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "/dev/vda"; # or "nodev" for efi only
  boot.loader.timeout = 1;

  #silent boot
  boot.kernelParams = ["quiet" "udev.log_level=0" "systemd.show_status=false"];
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;
}
