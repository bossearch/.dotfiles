{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Meslo" ]; })
    noto-fonts
    noto-fonts-lgc-plus
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
    emoji = [ "noto-fonts-color-emoji" ];
    };
  };
  home.file."/etc/fonts/conf.d/75-noto-color-emoji.conf" = {
    source = ./../configs/75-noto-color-emoji.conf;
  };
}
