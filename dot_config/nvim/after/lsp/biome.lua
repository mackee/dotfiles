---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    local marker = vim.fs.find({ 'biome.json', 'biome.jsonc' }, {
      path = vim.api.nvim_buf_get_name(bufnr),
      upward = true,
      type = 'file',
    })[1]
    if not marker then return end
    on_dir(vim.fs.dirname(marker))
  end,
  on_save_actions = { 'source.fixAll', 'source.organizeImports', 'format' },
}
