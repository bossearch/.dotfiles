{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    vesktop
  ];
  home.file.".config/vesktop/themes/tokyonight.theme.css" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/vesktop/tokyonight.theme.css";
  };
}
