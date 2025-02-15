return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.ai").setup()
    require("mini.surround").setup()
    require("mini.pairs").setup({
      modes = { insert = true, command = true, terminal = true },
    })
    require('mini.sessions').setup({
      autoread = false,                                     -- Auto-load session if no file is given
      autowrite = true,                                     -- Auto-save session before exiting

      directory = vim.fn.stdpath("state") .. "/session",    -- ~/.local/state/nvim/session
      file = "Session.vim",                                 -- Save session as 'Session.vim' inside the directory

      force = { read = true, write = true, delete = true }, -- Force overwrite if needed

      hooks = {
        pre = { read = nil, write = nil, delete = nil },
        post = { read = nil, write = nil, delete = nil },
      },

      verbose = { read = false, write = true, delete = true }, -- Show messages
    })
  end,
}
