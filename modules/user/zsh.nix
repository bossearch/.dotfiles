{config, ...}: {
  home.file.".config/zsh/.zshrc" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/zsh/.zshrc";
  };
  home.file.".zshenv" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/zsh/.zshenv";
  };
}
