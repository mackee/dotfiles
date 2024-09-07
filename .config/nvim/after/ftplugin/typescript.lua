vim.opt_local.sw = 2
vim.opt_local.ts = 2
vim.opt_local.expandtab = true

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.ts", "*.tsx"},
  callback = function()
    vim.lsp.buf.format({async = false})
  end
})
