local M = {}

local servers = {
  'denols',
  'ts_ls',
  'gopls',
  'zls',
  'perlnavigator',
  'biome',
  'eslint',
  'pyright',
  'terraformls',
  'lua_ls',
  'yamlls',
  'cssls',
}

local function setup_diagnostics()
  vim.diagnostic.config({
    severity_sort = true,
    virtual_text = { spacing = 2, prefix = '●' },
    float = { border = 'rounded' },
    jump = { float = true },
  })
end

local function setup_global_keymaps()
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
  vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end)
  vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
end

local function on_attach(ev)
  local bufnr = ev.buf
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format({ async = true }) end, opts)

  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if client and client:supports_method('textDocument/completion') then
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
  end
end

function M.setup()
  vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'popup' }

  setup_diagnostics()
  setup_global_keymaps()

  local group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true })
  vim.api.nvim_create_autocmd('LspAttach', { group = group, callback = on_attach })
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = group,
    callback = function(ev) require('lsp.format').run_on_save(ev.buf) end,
  })

  for _, name in ipairs(servers) do
    vim.lsp.enable(name)
  end
end

return M
