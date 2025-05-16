{
  programs.nixvim.plugins.mini = {
    enable = true;
    mockDevIcons = true;
    modules = {
      ai = {};
      surround = {};
      jump = {};
      jump2d = {};
      move = {};
      icons = {};
      pairs = {
        modes = {
          insert = true;
          command = true;
          terminal = true;
        };
      };
      sessions = {
        autoread = false;  # Auto-load session if no file is given
        autowrite = true;  # Auto-save session before exiting

        directory.__raw = ''vim.fn.stdpath ("state") .. "/session"'';  # ~/.local/state/nvim/session
        file = "Session.vim";  # Save session as 'Session.vim' inside the directory

        force = {
          read = true;
          write = true;
          delete = true;
        };

        hooks = {
          pre = {
            read = null;
            write = null;
            delete = null;
          };
          post = {
            read = null;
            write = null;
            delete = null;
          };
        };

        verbose = {
          read = false;
          write = true;
          delete = true;
        };
      };
    };
  };
}
