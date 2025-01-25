return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- For icons
    "nvim-lspconfig", -- For diagnostics integration
    "mfussenegger/nvim-dap", -- For debugging status
    "folke/noice.nvim", -- For Noice statusline integration (optional)
  },
  config = function()
    function _G.root_dir()
      local cwd = vim.fn.getcwd()
      local folder_name = vim.fn.fnamemodify(cwd, ":t") -- Get the folder name
      return "%#None#" .. folder_name
    end

    function _G.lsp_status()
      -- Get the current buffer
      local current_buf = vim.api.nvim_get_current_buf()

      -- Get all active LSP clients
      local clients = vim.lsp.get_active_clients()

      -- Loop through the active clients and check if the current buffer is attached
      for _, client in ipairs(clients) do
        if client.attached_buffers[current_buf] then
          return "" .. client.name -- LSP is active for this buffer
        end
      end

      return "No LSP" -- LSP is not attached to this buffer
    end

    require("lualine").setup({
      options = {
        theme = "auto",
        globalstatus = true, -- Enable global statusline
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        section_separators = { left = "", right = "" },
        component_separators = { left = "│", right = "│" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      sections = {
        lualine_a = { "mode" }, -- Current mode (e.g., NORMAL, INSERT)
        lualine_b = { "branch" }, -- Git branch name
        lualine_c = {
          -- _G.root_dir(),
          { _G.root_dir, icon = "󰝰", color = { fg = "#7aa2f7", bg = "#16161e" } },
          {
            "buffers",
            show_filename_only = false,
            hide_filename_extension = true,
            max_length = vim.o.columns * 4 / 3,
          },
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
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = "#bb9af7" },
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
          {
            function()
              return " " .. require("dap").status()
            end,
            cond = function()
              return package.loaded["dap"] and require("dap").status() ~= ""
            end,
            color = { fg = "#f7768e" },
          },
          -- { _G.lsp_status, icon = " ", color = { fg = "#ffffff", bg = "#2E3440" } },
        },
        lualine_y = { "%l/%L:%c│%p%%" },
        lualine_z = { { _G.lsp_status, icon = " " } },
      },
    })
  end,
}
