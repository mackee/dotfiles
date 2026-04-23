---@type vim.lsp.Config
return {
  root_dir = require("lspconfig").util.root_pattern("biome.json", "Biomefile"),
}
