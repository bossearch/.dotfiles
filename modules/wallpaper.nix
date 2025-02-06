{config, pkgs, ... }: 
{
  home.file."Pictures/Wallpapers" = {
    source = ./../wallpaper/Pictures/Wallpapers;
  };
}
