if not vim.filetype then
  return
end

vim.filetype.add {
  extension = {
    -- lock = "yaml",
    -- gotmpl = "gotmpl",
    -- org_archive = "org",
  },
  filename = {
    [".eslintrc"] = "jsonc",
    [".prettierrc"] = "jsonc",
    [".babelrc"] = "jsonc",
    [".flake8"] = "dosini",
    [".stignore"] = "gitignore",
    [".nixos.log"] = "sh",
    [".hm.log"] = "sh",
  },
  pattern = {
    [".env.*"] = "sh",
    ["*.Dockerfile.*"] = "dockerfile",
    ["*/templates/**/*.html"] = "htmldjango",
  },
}
