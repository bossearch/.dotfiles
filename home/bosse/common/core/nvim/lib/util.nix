{
  programs.nixvim = {
    extraFiles = {
      "lua/lib/util.lua".text = ''
        local util = {}

        -- usercmd --
        util.copy_to_clipboard = function(content)
          vim.fn.setreg("+", content)
          vim.notify('Copied "' .. content .. '" to the clipboard!', vim.log.levels.INFO)
        end

        -- usercmd --
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

        -- lualine --
        util.get_cwd = function()
          local cwd = vim.fn.getcwd()
          local folder_name = vim.fn.fnamemodify(cwd, ":t")
          return "%#None#" .. folder_name
        end

        -- lualine --
        local spinner_symbols = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
        local client_progress = {}

        -- Configurable options
        local opts = {
          show_default_progress = true, -- Set to false to hide Neovim's default LSP progress UI
        }

        -- Save the original handler so we can optionally call it
        local orig_progress_handler = vim.lsp.handlers["$/progress"]

        -- Hook into $/progress notifications to track status per client
        vim.lsp.handlers["$/progress"] = function(err, msg, ctx)
          local client_id = ctx.client_id
          local token = msg.token
          local value = msg.value

          if not client_progress[client_id] then
            client_progress[client_id] = {}
          end

          if value.kind == "begin" then
            client_progress[client_id][token] = true
          elseif value.kind == "end" then
            client_progress[client_id][token] = nil
          end

          -- Clean up empty tables
          if next(client_progress[client_id]) == nil then
            client_progress[client_id] = nil
          end

          -- Conditionally call the original handler
          if opts.show_default_progress and orig_progress_handler then
            orig_progress_handler(err, msg, ctx)
          end
        end

        -- Status function with proper spinner
        util.lsp_status = function()
          local clients = vim.lsp.get_clients { bufnr = vim.api.nvim_get_current_buf() }
          if #clients == 0 then
            return "No LSP"
          end

          local hrtime = (vim.uv or vim.loop).hrtime
          local frame = spinner_symbols[(math.floor(hrtime() / (1e6 * 100)) % #spinner_symbols) + 1]

          local results = {}
          for _, client in ipairs(clients) do
            local show_spinner = client_progress[client.id] ~= nil
            local icon = show_spinner and frame or "✓"
            table.insert(results, client.name .. " " .. icon)
          end

          return table.concat(results, " ")
        end

        -- oil --
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

        -- telescope --
        util.live_multigrep = function(opts)
          opts = opts or {}
          opts.cwd = opts.cwd or vim.uv.cwd()

          opts = vim.tbl_deep_extend("force", require("telescope.themes").get_ivy(), opts)

          local finder = require("telescope.finders").new_async_job({
            command_generator = function(prompt)
              if not prompt or prompt == "" then
                return nil
              end

              local pieces = vim.split(prompt, "  ")
              local args = { "rg" }
              if pieces[1] then
                table.insert(args, "-e")
                table.insert(args, pieces[1])
              end

              if pieces[2] then
                table.insert(args, "-g")
                table.insert(args, pieces[2])
              end

              ---@diagnostic disable-next-line: deprecated
              return vim.tbl_flatten({
                args,
                { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
              })
            end,
            entry_maker = require("telescope.make_entry").gen_from_vimgrep(opts),
            cwd = opts.cwd,
          })

          require("telescope.pickers")
            .new(opts, {
              debounce = 100,
              prompt_title = "Multi Grep",
              finder = finder,
              previewer = require("telescope.config").values.grep_previewer(opts),
              sorter = require("telescope.sorters").empty(),
            })
            :find()
        end

        return util
      '';
    };
  };
}
