{
  config,
  pkgs,
  lib,
  ...
}:
# let
# bat_cache= "${config.home.homeDirectory}/.cache/bat";
#in
{
  imports = [
    ./tokyonight_night.nix
  ];

  # home.packages = with pkgs; [
  #   bat
  # ];
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "tokyonight_night";
    };
    # themes = {
    #   dracula = {
    #     src = pkgs.fetchFromGitHub {
    #       owner = "dracula";
    #       repo = "sublime"; # Bat uses sublime syntax for its themes
    #       rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
    #       sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
    #     };
    #     file = "Dracula.tmTheme";
    #   };
    # };
  };

  # home.activation.updatebat = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #   if [ ! -d "${bat_cache}" ];  then
  #     ${pkgs.bat}/bin/bat cache --build
  #   fi
  # '';
}
