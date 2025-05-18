{
  programs.nixvim.plugins.snacks = {
    enable = true;
    settings = {
      dashboard = {
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
        };
      };
      indent = {
        indent = {
          enabled = false;
        };
        chunk = {
          enabled = true;
          only_current = true;
          char = {
            arrow = "─";
            corner_top = "╭";
            corner_bottom = "╰";
          };
          hl = "SnacksIndentScope";
        };
      };
      input = { enabled = true; };
      lazygit = { enabled = true; configure = true; };
      notifier = { enabled = true; };
      quickfile = { enabled = true; };
      scope = { enabled = true; };
      scroll = { enabled = false; };
      statuscolumn = { enabled = false; };
      words = { enabled = true; };
      zen = { enabled = true; };
    };
  };
}
