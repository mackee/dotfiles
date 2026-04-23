---@type vim.lsp.Config
return {
  root_dir = require("lspconfig").util.root_pattern("package.json"),
  single_file_support = false,
}
