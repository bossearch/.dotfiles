return function (lspconfig, capabilities)
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
      formatting = {
        command = { "stylua" },
      },
    },
  })
end
