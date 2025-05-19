[
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
]
