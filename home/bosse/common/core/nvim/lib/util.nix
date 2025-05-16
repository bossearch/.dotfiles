{
  programs.nixvim = {
    extraFiles = {
      "lua/lib/util.lua".text = ''
        local util = {}

        -- usercmd
        util.copy_to_clipboard = function(content)
          vim.fn.setreg("+", content)
          vim.notify('Copied "' .. content .. '" to the clipboard!', vim.log.levels.INFO)
        end

        -- usercmd
        util.get_root_dir = function()
            local bufname = vim.fn.expand('%:p')
            if vim.fn.filereadable(bufname) == 0 then
                return
            end

            local parent = vim.fn.fnamemodify(bufname, ':h')
            local git_root = vim.fn.systemlist('git -C ' .. parent .. ' rev-parse --show-toplevel')
            if #git_root > 0 and git_root[1] ~= ''\'' then
                return git_root[1]
            else
                return parent
            end
        end

        -- lualine
        util.root_dir = function()
          local cwd = vim.fn.getcwd()
          local folder_name = vim.fn.fnamemodify(cwd, ":t")
          return "%#None#" .. folder_name
        end

        -- lualine
        util.lsp_status = function()
          -- Get the current buffer
          local current_buf = vim.api.nvim_get_current_buf()

          -- Get all active LSP clients
          local clients = vim.lsp.get_clients()

          -- Loop through the active clients and check if the current buffer is attached
          for _, client in ipairs(clients) do
            if client.attached_buffers[current_buf] then
              return "" .. client.name -- LSP is active for this buffer
            end
          end

          return "No LSP" -- LSP is not attached to this buffer
        end

        -- oil
        util.get_oil_winbar = function()
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

        return util
      '';
    };
  };
}
