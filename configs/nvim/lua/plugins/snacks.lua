return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      enabled = true,
      sections = {
        { pane = 1, section = "header" },
        {
          icon = " ",
          title = "Recent Files\n",
          section = "recent_files",
          limit = 10,
          gap = 1,
          indent = 2,
          padding = 1,
        },
        {
          icon = " ",
          title = "Projects\n",
          section = "projects",
          limit = 5,
          gap = 1,
          indent = 2,
          padding = 1,
        },
        {
          pane = 1,
          section = "keys",
          padding = 1,
        },
        {
          pane = 1,
          section = "startup",
        },
      },
      preset = {
        keys = {
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
    indent = { enabled = false },
    input = { enabled = true },
    notifier = { enabled = true },
    lazygit = { enabled = true, configure = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    zen = { enabled = true },
  },
}
