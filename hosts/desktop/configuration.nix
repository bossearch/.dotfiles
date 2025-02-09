{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules/system/boot.nix
    ./../../modules/system/environtment.nix
    ./../../modules/system/firewall.nix
    ./../../modules/system/font.nix
    ./../../modules/system/hardware.nix
    ./../../modules/system/locale.nix
    ./../../modules/system/network.nix
    ./../../modules/system/security.nix
    ./../../modules/system/sound.nix
    ./../../modules/system/virtualization.nix
    ./../../modules/system/waydroid.nix
  ];

  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Asia/Singapore";

  # Enable CUPS to print documents.
  # services.printing.enable = true;


  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bosse = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "audio" "video" "libvirtd"];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  services = {
    blueman.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
