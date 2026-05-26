---@type vim.lsp.Config
return {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
  on_save_actions = { 'source.organizeImports', 'format' },
}
