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
      preset = "helix";
      spec = [
        # Window
        {
          __unkeyed = "<leader>w";
          group = "Window";
          icon = " ";
          mode = "n";
        }
        {
          __unkeyed = "<leader>wk";
          __unkeyed-1 = "<cmd>resize +2<cr>";
          desc = "Increase Window Height";
          mode = "n";
        }
        {
          __unkeyed = "<leader>wj";
          __unkeyed-1 = "<cmd>resize -2<cr>";
          desc = "Decrease Window Height";
          mode = "n";
        }
        {
          __unkeyed = "<leader>wh";
          __unkeyed-1 = "<cmd>vertical resize -2<cr>";
          desc = "Decrease Window Width";
          mode = "n";
        }
        {
          __unkeyed = "<leader>wl";
          __unkeyed-1 = "<cmd>vertical resize +2<cr>";
          desc = "Increase Window Width";
          mode = "n";
        }
        {
          __unkeyed = "<leader>wq";
          __unkeyed-1 = "<cmd>q<cr>";
          desc = "Quit Window";
          mode = "n";
        }
        {
          __unkeyed = "<leader>wbq";
          __unkeyed-1 = "<cmd>bd<cr>";
          desc = "Quit Buffer";
          mode = "n";
        }
        {
          __unkeyed = "<leader>wz";
          __unkeyed-1.__raw = ''
            function()
              require("snacks").zen()
            end
          '';
          desc = "Toggle Zen Mode";
          mode = "n";
        }
        {
          __unkeyed = "<leader>wm";
          __unkeyed-1.__raw = ''
            function()
              require("snacks").zen.zoom()
            end
          '';
          desc = "Maximize Window";
          mode = "n";
        }
        #split
        {
          __unkeyed = "<leader>-";
          __unkeyed-1 = "<C-W>s";
          icon = " ";
          desc = "Split Horizontally";
          mode = "n";
        }
        {
          __unkeyed = "<leader>|";
          __unkeyed-1 = "<C-W>v";
          icon = " ";
          desc = "Split Vertically";
          mode = "n";
        }
        # Highlight
        {
          __unkeyed = "<leader>hl";
          __unkeyed-1 = "<cmd>nohlsearch<bar>diffupdate<bar>normal! <C-L><cr>";
          desc = "Clear Search";
          mode = "n";
        }
        # Neo
        {
          __unkeyed = "<leader>n";
          group = "Neo";
          icon = " ";
          mode = "n";
        }
        {
          __unkeyed = "<leader>nf";
          __unkeyed-1 = "<cmd>enew<cr>";
          desc = "New File";
          mode = "n";
        }
        {
          __unkeyed = "<leader>nr";
          __unkeyed-1 = "<cmd>RootDir<cr>";
          desc = "Open Root Directory";
          mode = "n";
        }
        {
          __unkeyed = "<leader>nn";
          __unkeyed-1.__raw = ''
            function()
              require("snacks").notifier.show_history()
            end
          '';
          desc = "Show Notification History";
          mode = "n";
        }
        {
          __unkeyed = "<leader>nh";
          __unkeyed-1.__raw = ''
            function()
              require("snacks").notifier.hide()
            end
          '';
          desc = "Hide Notification";
          mode = "n";
        }
        # Terminal
        {
          __unkeyed = "<leader><CR>";
          group = "Terminal";
          icon = " ";
          mode = "n";
        }
        {
          __unkeyed = "<leader><CR><CR>";
          __unkeyed-1.__raw = ''
            function()
              require("snacks").terminal.toggle(nil, { win = { height = 0.5 } })
            end
          '';
          desc = "Toggle Terminal On Split";
          mode = ["n" "t"];
        }
        {
          __unkeyed = "<leader><CR>f";
          __unkeyed-1.__raw = ''
            function()
              require("snacks").terminal.toggle("zsh", {
                win = {
                  width = 0.5,         -- Width of the terminal
                  height = 0.5,        -- Height of the terminal
                  border = "rounded",  -- Sharp border style (use "double" if preferred)
                },
                cwd = vim.fn.getcwd(), -- Set the current working directory
              })
            end
          '';
          desc = "Toggle Terminal On Float";
          mode = ["n" "t"];
        }
        # LSP
        {
          __unkeyed = "<leader>l";
          group = "LSP";
          icon = " ";
          mode = "n";
        }
        {
          __unkeyed = "<leader>lf";
          __unkeyed-1.__raw = ''
            function()
              vim.lsp.buf.format({
                async = false,
                timeout_ms = 500,
              })
            end
          '';
          desc = "Format File";
          mode = ["n" "v"];
        }
        # Oil
        {
          __unkeyed = "<leader>/";
          group = "Oil";
          icon = "󱧶 ";
          mode = "n";
        }
        {
          __unkeyed = "<leader>//";
          __unkeyed-1.__raw = ''
            function()
              vim.g.oil_open_in_buffer = true
              require("oil").open()
            end
          '';
          desc = "Open Oil";
          mode = "n";
        }
        {
          __unkeyed = "<leader>/f";
          __unkeyed-1.__raw = ''
            function()
              vim.g.oil_open_in_buffer = false
              require("oil").toggle_float()
            end
          '';
          desc = "Open Oil On Floating Mode";
          mode = "n";
        }
        {
          __unkeyed = "<leader>/d";
          __unkeyed-1.__raw = ''
            function()
              detail = not detail
              if detail then
                require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
              else
                require("oil").set_columns({ "icon" })
              end
            end
          '';
          desc = "Open Oil On Detail View";
          mode = "n";
        }
        # Telescope
        {
          __unkeyed = "<leader>f";
          group = "Find";
          icon = " ";
          mode = "n";
        }
        {
          __unkeyed = "<leader>ff";
          __unkeyed-1 = "<cmd>Telescope find_files<cr>";
          desc = "Find Files In CWD";
          mode = "n";
        }
        {
          __unkeyed = "<leader>fr";
          __unkeyed-1 = "<cmd>Telescope oldfiles<cr>";
          desc = "Find Recent Files";
          mode = "n";
        }
        {
          __unkeyed = "<leader>fg";
          __unkeyed-1 = "<cmd>Telescope live_grep<cr>";
          desc = "Find String In CWD";
          mode = "n";
        }
        {
          __unkeyed = "<leader>fc";
          __unkeyed-1 = "<cmd>Telescope grep_string<cr>";
          desc = "Find String Under Cursor In CWD";
          mode = "n";
        }
        {
          __unkeyed = "<leader>fh";
          __unkeyed-1 = "<cmd>Telescope help_tags<cr>";
          desc = "Find Help Tags";
          mode = "n";
        }
        {
          __unkeyed = "<leader>fb";
          __unkeyed-1 = "<cmd>Telescope buffers<cr>";
          desc = "Find Buffer";
          mode = "n";
        }
        {
          __unkeyed = "<leader>ft";
          __unkeyed-1 = "<cmd>TodoTelescope<cr>";
          desc = "Find Todos";
          mode = "n";
        }
      ];
    };
  };
}
