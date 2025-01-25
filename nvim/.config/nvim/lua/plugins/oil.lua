return {
  "stevearc/oil.nvim",
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  config = function()
    -- Declare a global function to retrieve the current directory
    function _G.get_oil_winbar()
      -- Check if oil is opened in a new buffer
      if vim.g.oil_open_in_buffer then
        local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
        local dir = require("oil").get_current_dir(bufnr)
        if dir then
          return vim.fn.fnamemodify(dir, ":~")
        else
          -- If there is no current directory (e.g. over ssh), just show the buffer name
          return vim.api.nvim_buf_get_name(0)
        end
      end
      return "" -- Return an empty string for floating windows
    end

    local oil = require("oil")
    oil.setup({
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          local folder_skip = { "dev-tools.locks", "dune.lock", "_build" }
          return vim.tbl_contains(folder_skip, name)
        end,
      },

      win_options = {
        winbar = "%!v:lua.get_oil_winbar()",
      },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = false,
      float = {
        -- Padding around the floating window
        padding = 1,
        -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        max_width = 0.6,
        max_height = 0.8,
        border = "rounded",
      },
      preview_win = {
        update_on_cursor_moved = true, -- Update preview on cursor move
        preview_method = "fast_scratch", -- Use fast scratch method for preview
        disable_preview = function(filename)
          -- Disable preview for large files (>10MB)
          local file_size = vim.fn.getfsize(filename)
          return file_size > 10 * 1024 * 1024
        end,
        win_options = {
          wrap = false, -- Disable line wrapping in preview
          foldmethod = "indent", -- Use indentation for folding
        },
      },
    })
  end,
}
