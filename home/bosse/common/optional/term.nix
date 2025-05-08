{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    kitty
    # ghostty
    # (pkgs.callPackage ./../custompkgs/alacritty.nix {})
  ];

  # home.file.".config/alacritty" = {
  #   source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/alacritty";
  #   recursive = true;
  # };

  home.file.".config/kitty/kitty.conf" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/kitty/kitty.conf";
  };
}
