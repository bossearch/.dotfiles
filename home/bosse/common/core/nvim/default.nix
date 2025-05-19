{
  inputs,
  pkgs,
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
        # extraPlugins needs to add to this list
        standalonePlugins = [
          "copilot.lua"
          "blink.cmp"
          "colorful-winsep"
        ];
      };
    };
    extraPlugins = [pkgs.vimPlugins.colorful-winsep];
  };
}
