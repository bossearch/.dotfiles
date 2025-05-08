{
  config,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs-unstable; [
    qmk
  ];

  # hardware.keyboard.qmk.enable = false;

  home.file.".config/qmk" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/qmk";
    recursive = true;
  };
}
