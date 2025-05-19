{
  programs.nixvim.plugins.which-key = {
    enable = true;
    lazyLoad = {
      settings = {
        cmd = "WhichKey";
        event = "DeferredUIEnter";
      };
    };
    settings = {
      delay = 200;
      expand = 1;
      notify = true;
      preset = "classic"; # classic, modern, or helix
      spec =
        (import ./lsp.nix)
        ++ (import ./neo.nix)
        ++ (import ./oil.nix)
        ++ (import ./other.nix)
        ++ (import ./quickfix.nix)
        ++ (import ./split.nix)
        ++ (import ./telescope.nix)
        ++ (import ./terminal.nix)
        ++ (import ./window.nix);
    };
  };
}
