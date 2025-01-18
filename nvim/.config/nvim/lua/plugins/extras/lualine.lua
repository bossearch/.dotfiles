local M = {}

---@param icon string
---@param status fun(): nil|"ok"|"error"|"pending"
function M.status(icon, status)
  local colors = {
    ok = "#a9dc76", -- Replace with your desired colors
    error = "#ff6188",
    pending = "#fc9867",
  }
  return {
    function()
      return icon
    end,
    cond = function()
      return status() ~= nil
    end,
    color = function()
      return { fg = colors[status()] or colors.ok }
    end,
  }
end

---@param opts? {relative: "cwd"|"root", length: number?, modified_sign: string?}
function M.pretty_path(opts)
  opts = vim.tbl_extend("force", {
    relative = "cwd",
    length = 3,
    modified_sign = "[+]",
  }, opts or {})

  return function()
    local path = vim.fn.expand("%:p")
    if path == "" then
      return ""
    end

    local cwd = vim.fn.getcwd()
    if opts.relative == "cwd" and path:find(cwd, 1, true) == 1 then
      path = path:sub(#cwd + 2)
    end

    local parts = vim.split(path, "[\\/]")

    if #parts > opts.length then
      parts = { parts[1], "…", unpack(parts, #parts - opts.length + 2, #parts) }
    end

    if vim.bo.modified then
      parts[#parts] = parts[#parts] .. opts.modified_sign
    end

    return table.concat(parts, "/")
  end
end

---@param opts? {icon: string}
function M.root_dir(opts)
  opts = vim.tbl_extend("force", {
    icon = "󱉭 ",
  }, opts or {})

  return {
    function()
      local cwd = vim.fn.getcwd()
      return (opts.icon .. " " .. vim.fn.fnamemodify(cwd, ":t"))
    end,
    cond = function()
      return true
    end,
  }
end

return M
