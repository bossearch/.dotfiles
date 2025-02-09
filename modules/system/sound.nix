
{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pulseaudio
    playerctl
  ];
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
}
