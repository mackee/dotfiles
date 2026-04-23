---@type vim.lsp.Config
return {
  cmd = { vim.fn.expand('$HOME/.asdf/shims/perlnavigator'), '--stdio' },
  settings = {
    perlnavigator = {
      perlPath = vim.fn.expand("$HOME/.plenv/shims/perl"),
      includePaths = { vim.fn.expand("./local/lib/perl5") },
    },
  },
}
