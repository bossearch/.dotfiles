{config, ...}: {
  home.file.".config/zsh/.zshrc" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/zsh/.zshrc";
  };
  home.file.".config/zsh/.p10k.zsh" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/zsh/.p10k.zsh";
  };
  home.file.".zshenv" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/zsh/.zshenv";
  };
}
