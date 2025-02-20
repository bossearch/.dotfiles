{
  config,
  pkgs,
  inputs,
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

    # lsp
    lua-language-server
    nixd
    # formatter
    alejandra # nix
    # linter
  ];
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/nvim";
    recursive = true;
  };

  xdg.desktopEntries.nvim = {
    type = "Application";
    name = "Neovim";
    genericName = "Text Editor";
    icon = "nvim";
    exec = "alacritty -t nvim -e nvim %F";
    comment = "Edit text files";
    categories = ["Utility" "TextEditor"];
    mimeType = [
      "text/english"
      "text/plain"
      "text/x-makefile"
      "text/x-c++hdr"
      "text/x-c++src"
      "text/x-chdr"
      "text/x-csrc"
      "text/x-java"
      "text/x-moc"
      "text/x-pascal"
      "text/x-tcl"
      "text/x-tex"
      "application/x-shellscript"
      "text/x-c"
      "text/x-c++"
    ];
  };
}
