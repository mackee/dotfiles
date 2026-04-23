return {
  "Shougo/ddc.vim",
  dependencies = {
    'vim-denops/denops.vim',
    'Shougo/ddc-ui-native',
    'Shougo/ddc-source-nvim-lsp',
    'uga-rosa/ddc-nvim-lsp-setup',
    'neovim/nvim-lspconfig',
    'Shougo/ddc-filter-matcher_head',
    'Shougo/ddc-filter-matcher_prefix',
    'Shougo/ddc-filter-sorter_rank',
    'Shougo/ddc-filter-converter_remove_overlap',
    'Shougo/ddc-filter-converter_truncate_abbr',
    'matsui54/denops-signature_help',
    'matsui54/denops-popup-preview.vim',
    'github/copilot.vim',
    { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
    -- 'Shougo/ddc-source-copilot',
  },
  config = function()
    vim.fn['ddc#custom#patch_global']('ui', 'native')
    -- vim.fn['ddc#custom#patch_global']('sources', {'lsp', 'copilot'})
    vim.fn['ddc#custom#patch_global']('sources', { 'lsp' })
    vim.fn['ddc#custom#patch_global']('sourceOptions', {
      _ = {
        matchers = { 'matcher_head', 'matcher_prefix' },
        sorters = { 'sorter_rank' },
        converters = { "converter_truncate_abbr", "converter_remove_overlap" },
      },
      lsp = {
        mark = 'LSP',
        matchers = { 'matcher_prefix' },
        dup = 'keep',
        --keywordPattern = '\\+k',
        --keywordPattern = '[a-zA-Z0-9_À-ÿ$#\\-*]*',
        sorters = { 'sorter_rank' },
        -- forceCompletionPattern = '\\.|:|->|"\\w+/*',
        timeout = 500,
      },
      -- ['copilot'] = {
      --  mark = 'copilot',
      --  matchers = {},
      --  minAutoCompleteLength = 0,
      -- },
    })
    vim.fn['ddc#custom#patch_global']('sourceParams', {
      ['lsp'] = {
        snippetEngine = vim.fn["denops#callback#register"](function(body)
          require("luasnip").lsp_expand(body)
        end),
        enableResoveItem = true,
        enableAdditionalTextEdit = true,
        confirmBehavior = 'replace',
        timeout = 500,
      },
    })
    vim.g.copilot_no_maps = true

    require("ddc_source_lsp_setup").setup()
    vim.lsp.enable("denols")
    vim.lsp.enable("ts_ls")
    vim.lsp.enable("gopls")
    vim.lsp.enable("zls")
    vim.lsp.enable("perlnavigator")
    vim.lsp.enable("biome")
    vim.lsp.enable("eslint")
    vim.lsp.enable("pyright")
    vim.lsp.enable("terraformls")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("yamlls")
    vim.lsp.enable("cssls")

    vim.fn['ddc#enable']()
    vim.fn['popup_preview#enable']()
    vim.fn['signature_help#enable']()

    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
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
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end,
    })

    require("lsp").setup()
  end,
}
