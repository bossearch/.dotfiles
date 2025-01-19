return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- For icons
    "nvim-lspconfig", -- For diagnostics integration
    "mfussenegger/nvim-dap", -- For debugging status
    "folke/noice.nvim", -- For Noice statusline integration (optional)
  },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        globalstatus = true, -- Enable global statusline
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        -- section_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },
        -- component_separators = { left = "╱", right = "│" },
        component_separators = { left = "│", right = "│" },
      },
      sections = {
        lualine_a = { "mode" }, -- Current mode (e.g., NORMAL, INSERT)
        lualine_b = { "branch" }, -- Git branch name
        lualine_c = {
          require("plugins.extras.lualine").root_dir(),
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } }, -- File type icon
          require("plugins.extras.lualine").pretty_path(),
          {
            "diagnostics",
            sources = { "nvim_diagnostic" }, -- Use LSP diagnostics
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = "󰠠 ",
            },
            colored = true,
            update_in_insert = false,
          },
        },
        lualine_x = {
          {
            require("noice").api.status.command.get,
            cond = require("noice").api.status.command.has,
            color = { fg = "#ff9e64" },
          },
          {
            require("noice").api.status.mode.get,
            cond = require("noice").api.status.mode.has,
            color = { fg = "#7aa2f7" },
          },
          -- ,
          {
            function()
              return " " .. require("dap").status()
            end,
            cond = function()
              return package.loaded["dap"] and require("dap").status() ~= ""
            end,
            color = { fg = "#f7768e" },
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = "#c0caf5" },
          },
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = { "%l/%L:%c" },
        lualine_z = { "%p%%" },
      },
      extensions = { "neo-tree", "lazy", "fzf" },
    })
  end,
}
