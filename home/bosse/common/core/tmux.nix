{
  config,
  pkgs,
  lib,
  ...
}: let
  tpmpath = "${config.home.homeDirectory}/.config/tmux/plugins/tpm";
in {
  home.packages = with pkgs; [
    tmux
  ];
  home.file.".config/tmux/tmux.conf" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/tmux/tmux.conf";
  };

  home.activation.clonetpm = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -d "${tpmpath}" ];  then
      ${pkgs.git}/bin/git clone https://github.com/tmux-plugins/tpm "${tpmpath}"
    fi
  '';
}
