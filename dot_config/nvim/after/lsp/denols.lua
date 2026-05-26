---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    local marker = vim.fs.find({ 'deno.json', 'deno.jsonc' }, {
      path = vim.api.nvim_buf_get_name(bufnr),
      upward = true,
      type = 'file',
    })[1]
    if not marker then return end
    on_dir(vim.fs.dirname(marker))
  end,
  init_options = {
    lint = true,
    unstable = true,
    suggest = {
      imports = {
        hosts = {
          ["https://deno.land"] = true,
          ["https://cdn.nest.land"] = true,
          ["https://crux.land"] = true,
        },
      },
    },
  },
}
