require("lspconfig").tsserver.setup({
  settings = {
    implicitProjectConfiguration = {
      checkJs = true,
    },
  },
})
