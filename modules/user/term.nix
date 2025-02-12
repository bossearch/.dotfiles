{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    (pkgs.callPackage ./../custompkgs/alacritty.nix {})
  ];

  home.file.".config/alacritty" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/alacritty";
    recursive = true;
  };
}
