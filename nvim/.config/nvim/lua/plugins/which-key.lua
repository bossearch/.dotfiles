-- TODO: add more setup for which-key
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 1
  end,
  opts = {
    preset = "helix",
  },
}
