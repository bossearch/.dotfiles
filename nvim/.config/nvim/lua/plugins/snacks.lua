-- TODO: find a way to move key settings to keymaps.lua
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    -- bigfile = { enabled = true },
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
    indent = { enabled = true },
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
  keys = {
    {
      "<leader>wm",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Toggle Window Zoom",
    },
    {
      "<leader>tz",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>lg",
      function()
        Snacks.lazygit()
      end,
      desc = "Open lazygit",
    },
    {
      "<leader>n",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },
    {
      "<leader>nq",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
  },
}
