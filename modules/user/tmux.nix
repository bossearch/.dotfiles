{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    tmux
  ];
  home.file.".config/tmux/tmux.conf" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/tmux/tmux.conf";
  };
  home.file.".config/tmux/plugins/tpm" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/tmux/tpm";
    recursive = true;
  };
}
