[
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
]
