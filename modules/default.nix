{ config, lib, pkgs, ... }:

let
  configPath = "/home/bosse/.dotfiles/configs";  # Adjust this path to where your configs reside
in {
  # Ensure the symlink function is defined at the top-level scope
  mkMutableSymlink = path: lib.file.mkOutOfStoreSymlink
    (configPath + lib.string.removePrefix (toString pkgs.inputs.self) (toString path));
}

