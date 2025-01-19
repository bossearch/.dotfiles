return {
  "stevearc/oil.nvim",
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  config = function()
    local detail = false
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
      delete_to_trash = true,
      skip_confirm_for_simple_edits = false,
      preview_win = {
        -- Whether the preview window is automatically updated when the cursor is moved
        update_on_cursor_moved = true,
        -- How to open the preview window "load"|"scratch"|"fast_scratch"
        preview_method = "fast_scratch",
      },
      keymaps = {
        ["d/"] = {
          desc = "Toggle file detail view",
          callback = function()
            detail = not detail
            if detail then
              require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
            else
              require("oil").set_columns({ "icon" })
            end
          end,
        },
      },
    })
    vim.keymap.set("n", "<leader>/", "<CMD>Oil<CR>", { desc = "Open parent directory with oil" })
    vim.keymap.set("n", "<leader>f/", oil.toggle_float, { desc = "Open parent directory with oil float" })
  end,
}
