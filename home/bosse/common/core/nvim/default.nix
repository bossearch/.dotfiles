{
  inputs,
  # pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./core
    ./lib
    ./plugins
  ];
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    dependencies = {
      gh.enable = true;
    };
    performance = {
      byteCompileLua = {
        enable = true;
        nvimRuntime = true;
        configs = true;
        plugins = true;
      };
      combinePlugins = {
        enable = true;
        pathsToLink = ["/plugins"];
        standalonePlugins = [
          "copilot.lua"
          "blink.cmp"
          "nvim-treesitter"
        ];
      };
    };
    # extraPlugins = let
    #   colorful-winsep = pkgs.vimUtils.buildVimPlugin {
    #     name = "colorful-winsep";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "nvim-zh";
    #       repo = "colorful-winsep.nvim";
    #       rev = "7bbe4e1353c0fe37c98bad2758aafc410280f6b3";
    #       sha256 = "sha256-3ZXbpUNZqLHaUWgb2wHnfQfcGkMpcRtAt8q7z0tmo1o=";
    #     };
    #   };
    # in [
    #   colorful-winsep
    # ];
  };
}
