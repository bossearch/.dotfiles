{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./core
    ./lib
    ./plugins
  ];
  programs.nixvim = {
    enable = true;
    extraConfigLuaPre = ''
      vim.deprecate = function() end
    '';
  };
}
