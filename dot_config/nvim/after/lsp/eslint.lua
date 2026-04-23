---@type vim.lsp.Config
return {
  root_dir = require("lspconfig").util.root_pattern("eslint.config.js", ".eslintrc"),
  on_attach = function(client, bufnr)
    _ = client
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
}
