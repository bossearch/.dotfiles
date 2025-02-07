{config, pkgs, ... }: 
{
  # home.file."Pictures/Wallpapers" = {
  #   source = ./../wallpaper/Pictures/Wallpapers;
  # };
  #
  home.file."Pictures/Wallpapers" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/wallpaper/Pictures/Wallpapers";
    recursive = true;
  };
}
