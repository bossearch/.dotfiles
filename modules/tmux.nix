{ config, pkgs, ... }:

# let
#   myPkgs = pkgs // {
#     tmuxPlugins = pkgs.callPackage ./../modules/custompkgs/tmuxtest.nix {};
#   };
# in 
{
  # home.packages = with pkgs; [
  #   tmux
  #   tmuxPlugins.tokyo-night-tmux
  # ];
programs.tmux = {
  enable = true;
};
  # nixpkgs.config.packageOverrides = pkgs: {
  #   tmuxPlugins = pkgs.callPackage ./custompkgs/tmuxtest.nix {};
  # };

  home.file.".config/tmux" = {
    source = ./../configs/tmux;
  };
}

