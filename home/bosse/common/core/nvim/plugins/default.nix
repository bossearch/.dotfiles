# TODO: Do i need trouble, treesj, substitute, gitsigns, comment, typr
{lib, ...}: let
  inherit (builtins) readDir;
  inherit (lib.attrsets) foldlAttrs;
  inherit (lib.lists) optional;
  by-name = ./.;
in {
  imports =
    foldlAttrs
    (acc: name: type:
      acc
      ++ optional
      (type == "directory" && name != ".disable")
      (by-name + "/${name}/default.nix"))
    []
    (readDir by-name);
}
