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
    ./../../modules/system/services.nix
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bosse = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "audio" "video" "libvirtd"];
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Do not change these future me !
  system.stateVersion = "24.11"; # Did you read the comment?
}
