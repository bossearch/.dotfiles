{config, ...}: {
  imports = [
    ./../../modules/hardware-configuration.nix
    ./../../modules/system/boot.nix
    ./../../modules/system/displaymanager.nix
    ./../../modules/system/firewall.nix
    ./../../modules/system/font.nix
    ./../../modules/system/hardware.nix
    ./../../modules/system/locale.nix
    ./../../modules/system/misc.nix
    ./../../modules/system/network.nix
    ./../../modules/system/security.nix
    ./../../modules/system/sound.nix
    ./../../modules/system/udev.nix
    ./../../modules/system/usbguard.nix
    ./../../modules/system/virtualization.nix
    ./../../modules/system/waydroid.nix
  ];

  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
  };

  home-manager.extraSpecialArgs = {
    hostName = {
      vm = config.networking.hostName == "vm";
      desktop = config.networking.hostName == "desktop";
    };
  };

  # Set your time zone.
  time.timeZone = "Asia/Singapore";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bosse = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "audio" "video" "libvirtd"];
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Do not change these future me !
  system.stateVersion = "24.11"; # Did you read the comment?
}
