{ config, pkgs, inputs, lib, ... }:
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in
  {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblockify
    ];
    # enabledCustomApps = with spicePkgs.apps; [
    #   newReleases
    #   ncsVisualizer
    # ];
    # enabledSnippets = with spicePkgs.snippets; [
    #   rotatingCoverart
    #   pointer
    # ];

    theme = spicePkgs.themes.text;
    colorScheme = "TokyoNight";
  };
}
