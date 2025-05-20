{
  programs.nixvim.plugins.mini = {
    enable = true;
    lazyLoad = {
      settings = {
        event = ["VimEnter"];
      };
    };
    mockDevIcons = true;
    modules = {
      ai = {};
      surround = {};
      jump = {};
      jump2d = {};
      move = {};
      icons = {};
      pairs = import ./pairs.nix;
      sessions = import ./sessions.nix;
    };
  };
}
