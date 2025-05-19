{
  programs.nixvim.plugins.snacks = {
    enable = true;
    settings = {
      dashboard = import ./dashboard.nix;
      indent = import ./indent.nix;
      terminal = import ./terminal.nix;
      lazygit = import ./lazygit.nix;
      input = {enabled = true;};
      notifier = {enabled = true;};
      quickfile = {enabled = true;};
      scope = {enabled = true;};
      scroll = {enabled = false;};
      statuscolumn = {enabled = false;};
      words = {enabled = true;};
      zen = {enabled = true;};
    };
  };
}
