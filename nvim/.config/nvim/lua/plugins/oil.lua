return {
  "stevearc/oil.nvim",
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  config = function()
    local oil = require("oil")
    oil.setup({
      default_file_explorer = true,
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      preview_win = {
        -- Whether the preview window is automatically updated when the cursor is moved
        update_on_cursor_moved = true,
        -- How to open the preview window "load"|"scratch"|"fast_scratch"
        preview_method = "fast_scratch",
      },
    })
    vim.keymap.set("n", "<leader>/", "<CMD>Oil<CR>", { desc = "Open parent directory with oil" })
    vim.keymap.set("n", "<leader>f/", oil.toggle_float, { desc = "Open parent directory with oil float" })
  end,
}
