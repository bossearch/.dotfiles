return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
  config = function()
    require("treesj").setup({
      -- use_default_keymaps = false,
      -- cursor_behavior = "hold",
      -- langs = {
      --   lua = require("treesj.langs.lua"),
      -- },
      -- dot_repeat = true,
    })
    vim.keymap.set("n", "<leader>sj", "<cmd>TSJToggle<cr>", { desc = "Toggle TreeSJ" })
  end,
}
