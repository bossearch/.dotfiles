return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.ai").setup()
    require("mini.surround").setup({
      -- mappings = {
      --   add = "gsa",
      --   delete = "gsd",
      --   find = "gsf",
      --   find_left = "gsF",
      --   highlight = "gsh",
      --   replace = "gsr",
      --   update_n_lines = "gsn",
      -- },
    })
    require("mini.pairs").setup({
      modes = { insert = true, command = true, terminal = true },
    })
  end,
}
