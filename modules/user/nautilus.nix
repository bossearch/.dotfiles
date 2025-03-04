{
  config,
  lib,
  pkgs,
  ...
}: let
  Vaults_dir = "${config.home.homeDirectory}/.local/share/Vaults/{Secrets,Lofi}";
  Home_dir = "${config.home.homeDirectory}/{Desktop,Downloads,Documents,Pictures,Videos,Vaults}";
in {
  home.packages = with pkgs; [
    nautilus
    sushi
    vaults
    (pkgs.callPackage ./../custompkgs/varia.nix {})
  ];

  dconf.settings = {
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
    };
    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
    };
    "org/gnome/desktop/privacy" = {
      remember-recent-files = false;
    };
  };

  home.activation.vaultdir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -d "${Vaults_dir}" ];  then
      ${pkgs.coreutils}/bin/mkdir -p ${Vaults_dir}
    fi
  '';

  home.activation.homedir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -d "${Home_dir}" ];  then
      ${pkgs.coreutils}/bin/mkdir -p ${Home_dir}
    fi
  '';

  home.file.".config/user_config.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/vaults/user_config.toml";
  };

  home.file.".config/gtk-3.0/bookmarks".text = ''
    file:///home/bosse/Desktop Desktop
    file:///home/bosse/Downloads Downloads
    file:///home/bosse/Documents Documents
    file:///home/bosse/Pictures Pictures
    file:///home/bosse/Videos Videos
    file:///home/bosse/Vaults Vaults
  '';

  home.file.".config/user-dirs.dirs".text = ''
    XDG_DESKTOP_DIR="$HOME/Desktop"
    XDG_DOCUMENTS_DIR="$HOME/Documents"
    XDG_DOWNLOAD_DIR="$HOME/Downloads"
    XDG_MUSIC_DIR="$HOME/Music"
    XDG_PICTURES_DIR="$HOME/Pictures"
    XDG_VIDEOS_DIR="$HOME/Videos"
  '';
}
