local util = {}

    util.get_oil_winbar = function()
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

util.get_root_dir = function()
    local bufname = vim.fn.expand('%:p')
    if vim.fn.filereadable(bufname) == 0 then
        return
    end

    local parent = vim.fn.fnamemodify(bufname, ':h')
    local git_root = vim.fn.systemlist('git -C ' .. parent .. ' rev-parse --show-toplevel')
    if #git_root > 0 and git_root[1] ~= '' then
        return git_root[1]
    else
        return parent
    end
end

util.get_file_path = function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    if vim.fn.filereadable(buf_name) == 1 then
        return buf_name
    end

    local dir_name = vim.fn.fnamemodify(buf_name, ':p:h')
    if vim.fn.isdirectory(dir_name) == 1 then
        return dir_name
    end

    return vim.loop.cwd()
end

util.get_file_type_cmd = function(extension)
    local root = util.get_root_dir()

    if extension == 'arb' and root then
        local gemfile_exists = vim.fn.filereadable(root .. '/Gemfile') == 1
        local pubspec_exists = vim.fn.filereadable(root .. '/pubspec.yaml') == 1
        if gemfile_exists then
            return 'setfiletype ruby'
        end
        if pubspec_exists then
            return 'setfiletype json'
        end
    end
    return ''
end

util.is_present = function(bin)
    return vim.fn.executable(bin) == 1
end

util.telescope_select = function(options, options_desc, select_prompt)
    require('telescope.pickers')
        .new({}, {
            prompt_title = select_prompt,
            results_title = options_desc,
            finder = require('telescope.finders').new_table({
                results = options,
                entry_maker = require('telescope.make_entry').gen_from_file(),
            }),
            sorter = require('telescope.sorters').get_fzy_sorter(),
            previewer = require('telescope.previewers').vim_buffer_cat.new({}),
        })
        :find()
end

return util
