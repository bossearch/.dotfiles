{ config, pkgs, ... }:

# let
#   myPkgs = pkgs // {
#     tmuxPlugins = pkgs.callPackage ./../modules/custompkgs/tmuxtest.nix {};
#   };
# in 
{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Meslo" ]; })
    papirus-icon-theme
    noto-fonts
    noto-fonts-lgc-plus
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
  fonts.fontconfig.enable = true;
  home.file.".config/tmux" = {
    source = ./../configs/tmux;
  };
}

