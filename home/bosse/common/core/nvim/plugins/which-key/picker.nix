# TODO: fix desc and check unused picker
[
  # picker
  {
    __unkeyed = "<leader><space>";
    group = "Picker";
    icon = "󰢷 ";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space><space>";
    __unkeyed-1 = "<cmd>lua Snacks.picker.smart()<cr>";
    desc = "Smart Find Files";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>f";
    __unkeyed-1 = "<cmd>lua Snacks.picker.files()<cr>";
    desc = "Find Files In CWD";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>p";
    __unkeyed-1 = "<cmd>lua Snacks.picker.projects()<cr>";
    desc = "Find Todos";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>r";
    __unkeyed-1 = "<cmd>lua Snacks.picker.recent()<cr>";
    desc = "Find Recent Files";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>g";
    __unkeyed-1 = "<cmd>lua Snacks.picker.grep()<cr>";
    desc = "Find String In CWD";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>c";
    __unkeyed-1 = "<cmd>lua Snacks.picker.grep_word()<cr>";
    desc = "Find String Under Cursor In CWD";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>l";
    __unkeyed-1 = "<cmd>lua Snacks.picker.lines()<cr>";
    desc = "Find String Under Cursor In CWD";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>q";
    __unkeyed-1 = "<cmd>lua Snacks.picker.qflist()<cr>";
    desc = "Find String Under Cursor In CWD";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>h";
    __unkeyed-1 = "<cmd>lua Snacks.picker.help()<cr>";
    desc = "Find Help Tags";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>b";
    __unkeyed-1 = "<cmd>lua Snacks.picker.buffers()<cr>";
    desc = "Find Buffer";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>d";
    __unkeyed-1 = "<cmd>lua Snacks.picker.diagnostics()<cr>";
    desc = "Find Diagnostic";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>t";
    __unkeyed-1 = "<cmd>lua Snacks.picker.todo_comments()<cr>";
    desc = "Find Todos";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>.";
    __unkeyed-1 = "<cmd>lua Snacks.picker.icons()<cr>";
    desc = "Find Todos";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>n";
    __unkeyed-1 = "<cmd>lua Snacks.picker.notifications()<cr>";
    desc = "Find Todos";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>:";
    __unkeyed-1 = "<cmd>lua Snacks.picker.command_history()<cr>";
    desc = "Find Todos";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>/";
    __unkeyed-1 = "<cmd>lua Snacks.picker.search_history()<cr>";
    desc = "Find Todos";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>''\"";
    __unkeyed-1 = "<cmd>lua Snacks.picker.registers()<cr>";
    desc = "Find Todos";
    mode = "n";
  }
]
