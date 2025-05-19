{
  enabled = true;
  sections = [
    {
      pane = 1;
      section = "header";
    }
    {
      icon = " ";
      title = "Recent Files\n";
      section = "recent_files";
      limit = 10;
      gap = 1;
      indent = 2;
      padding = 1;
    }
    {
      icon = " ";
      title = "Projects\n";
      section = "projects";
      limit = 5;
      gap = 1;
      indent = 2;
      padding = 1;
      pick = true;
      session = false;
    }
    {
      pane = 1;
      section = "keys";
      padding = 1;
    }
    {
      pane = 1;
      section = "terminal";
      cmd = "~/.config/nvim/lua/lib/startup.sh";
      indent = 16;
      ttl = 0;
    }
  ];
  preset = {
    keys = [
      {
        icon = " ";
        key = "s";
        desc = "Restore Session";
        action = ":lua MiniSessions.read('global-session')";
        padding = 1;
      }
      {
        icon = " ";
        key = "q";
        desc = "Quit";
        action = ":qa";
      }
    ];
    header = ''
      ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗
      ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║
      ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║
      ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
      ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
    '';
  };
}
