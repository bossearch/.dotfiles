return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.ai").setup()
    require("mini.icons").setup()
    require("mini.surround").setup()
    require("mini.pairs").setup({
      modes = { insert = true, command = true, terminal = true },
    })
  end,
}
