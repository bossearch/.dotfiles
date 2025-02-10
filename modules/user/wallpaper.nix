{
  config,
  pkgs,
  ...
}: {
  home.file."Pictures/Wallpapers" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/wallpapers";
    recursive = true;
  };
}
