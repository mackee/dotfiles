---@type vim.lsp.Config
return {
  root_markers = { 'pyproject.toml' },
  cmd = { "rye", "run", "pyright-langserver", "--stdio" },
}
