---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    if vim.fs.find({ 'deno.json', 'deno.jsonc' }, { path = fname, upward = true, type = 'file' })[1] then
      return
    end
    local marker = vim.fs.find({ 'package.json', 'tsconfig.json' }, {
      path = fname,
      upward = true,
      type = 'file',
    })[1]
    if not marker then return end
    on_dir(vim.fs.dirname(marker))
  end,
}
