-- TODO: Migrate keymaps.lua to which-key.lua
-- TODO: Make use of list.lua for separate plugins and their config
-- TODO: flash.nvim

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Setup lazy.nvim
-- local plug = require("plugins.list").plugins
require("lazy").setup({
  {
    import = "plugins",
  },
  {
    import = "plugins.lsp",
  },

  -- spec = plug,
}, {
  -- defaults = { lazy = true },
  -- automatically check for plugin updates
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        -- "tarPlugin",
        "tohtml",
        -- "tutor",
        "zipPlugin",
      },
    },
  },
})
