---@type vim.lsp.Config
return {
  root_dir = require("lspconfig").util.root_pattern("pyproject.toml"),
  cmd = { "rye", "run", "pyright-langserver", "--stdio" },
}
