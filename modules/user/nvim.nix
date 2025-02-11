{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    cmake
    gnumake42
    libgcc
    llvmPackages_19.libcxxClang
    lua51Packages.lua
    lua51Packages.luarocks
    nodejs_23
    python39
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.sessionVariables = {
    LUA_PATH = "${pkgs.luajit}/share/lua/5.1/?.lua;;";
    LUA_CPATH = "${pkgs.luajit}/lib/lua/5.1/?.so;;";
  };

  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/nvim";
    recursive = true;
  };
}
