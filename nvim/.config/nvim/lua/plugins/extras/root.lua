---@class plugins.extras.root
---@overload fun(): string
local M = setmetatable({}, {
  __call = function(m)
    return m.get()
  end,
})

---@alias RootFn fun(buf: number): (string|string[])

M.spec = { "lsp", { ".git", "lua" }, "cwd" }

M.detectors = {}

M.detectors.cwd = function()
  return { vim.uv.cwd() }
end

M.detectors.lsp = function(buf)
  local bufpath = vim.api.nvim_buf_get_name(buf)
  if bufpath == "" then
    return {}
  end
  local roots = {}
  local clients = vim.lsp.get_active_clients({ bufnr = buf })
  for _, client in pairs(clients) do
    if client.config.workspace_folders then
      for _, ws in pairs(client.config.workspace_folders) do
        roots[#roots + 1] = vim.uri_to_fname(ws.uri)
      end
    elseif client.root_dir then
      roots[#roots + 1] = client.root_dir
    end
  end
  return roots
end

M.detectors.pattern = function(buf, patterns)
  patterns = type(patterns) == "string" and { patterns } or patterns
  local path = vim.api.nvim_buf_get_name(buf)
  local pattern = vim.fs.find(function(name)
    for _, p in ipairs(patterns) do
      if name == p then
        return true
      end
    end
  end, { path = path, upward = true })[1]
  return pattern and { vim.fs.dirname(pattern) } or {}
end

M.get = function(opts)
  opts = opts or {}
  local buf = opts.buf or vim.api.nvim_get_current_buf()
  for _, spec in ipairs(M.spec) do
    local roots = M.detectors[spec] and M.detectors[spec](buf) or {}
    if #roots > 0 then
      return roots[1]
    end
  end
  return vim.uv.cwd()
end

return M
