local function load_config(package)
  return function()
    require("plugins." .. package)
  end
end

local plugins = {
  -- UI
  {
    "folke/tokyonight.nvim",
    config = load_config("ui.tokyonight"),
    lazy = false,
    priority = 1000,
  },
  { "nvim-tree/nvim-web-devicons" },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = load_config("ui.snacks"),
  },
  -- TOOLS
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "debugloop/telescope-undo.nvim",
    },
    config = load_config("tools.telescope"),
    cmd = "Telescope",
  },
  {
    "folke/which-key.nvim",
    config = load_config("tools.which-key"),
    event = "VeryLazy",
  },
  {
    "stevearc/oil.nvim",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    config = load_config("tools.oil"),
  },
  -- EDITOR
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = load_config("code.treesitter"),
  },
}
return { plugins = plugins }
