{pkgs ? import <nixpkgs> {}, ...}: {
  # Packages with an actual source
  sysboard = pkgs.callPackage ./sysboard {};
  varia = pkgs.python3Packages.callPackage ./varia {};
}
