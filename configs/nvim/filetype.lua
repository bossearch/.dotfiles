if not vim.filetype then
  return
end

vim.filetype.add {
  extension = {
    vpy = "python",
  },
  filename = {
    [".eslintrc"] = "jsonc",
    [".prettierrc"] = "jsonc",
    [".babelrc"] = "jsonc",
    [".flake8"] = "dosini",
    [".stignore"] = "gitignore",
    [".vpy"] = "python",
    [".nixos.log"] = "sh",
    [".hm.log"] = "sh",
  },
  pattern = {
    [".env.*"] = "sh",
    ['.*/hypr/.*%.conf'] = 'hyprlang',
    ['.*/kitty/.*%.conf'] = 'sh',
    ['.*/waybar/config'] = 'jsonc',
  },
}
