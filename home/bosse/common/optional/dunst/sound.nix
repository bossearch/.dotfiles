{config, ...}: {
  home.file.".config/dunst/sound" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/bosse/common/optional/dunst/assets";
    recursive = true;
  };
}
