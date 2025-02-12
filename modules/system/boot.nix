{
  config,
  lib,
  ...
}: let
  hostName = {
    vm = config.networking.hostName == "vm";
    desktop = config.networking.hostName == "desktop";
  };
in {
  boot = lib.mkMerge [
    (lib.mkIf hostName.desktop {
      # Use systemd bootload
      loader.systemd-boot.enable = true;
      loader.systemd-boot.consoleMode = "max";
      loader.efi.canTouchEfiVariables = true;
      loader.timeout = 1;
      #silent boot
      kernelParams = ["quiet" "udev.log_level=0" "systemd.show_status=false"];
      initrd.verbose = false;
      consoleLogLevel = 0;
    })

    (lib.mkIf hostName.vm {
      loader.grub.enable = true;
      loader.grub.device = "/dev/vda"; # or "nodev" for efi only
      loader.timeout = 1;
      #silent boot
      kernelParams = ["quiet" "udev.log_level=0" "systemd.show_status=false"];
      initrd.verbose = false;
      consoleLogLevel = 0;
    })
  ];
}
