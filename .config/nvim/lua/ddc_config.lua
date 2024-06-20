return {
  "Shougo/ddc.vim",
  dependencies = {
    'vim-denops/denops.vim',
    'Shougo/ddc-ui-native',
    'Shougo/ddc-source-nvim-lsp',
    'uga-rosa/ddc-nvim-lsp-setup',
    'neovim/nvim-lspconfig',
    'Shougo/ddc-filter-matcher_head',
    'Shougo/ddc-filter-sorter_rank',
    'Shougo/ddc-filter-converter_remove_overlap',
    'matsui54/denops-signature_help',
    'matsui54/denops-popup-preview.vim',
    'github/copilot.vim',
    -- 'Shougo/ddc-source-copilot',
  },
  config = function()
    vim.fn['ddc#custom#patch_global']('ui', 'native')
    -- vim.fn['ddc#custom#patch_global']('sources', {'lsp', 'copilot'})
    vim.fn['ddc#custom#patch_global']('sources', {'lsp'})
    vim.fn['ddc#custom#patch_global']('sourceOptions', {
      _ = {
        matchers = {'matcher_head'},
        sorters = {'sorter_rank'},
        converters = {'converter_remove_overlap'},
      },
      ['lsp'] = {
        mark = 'LSP', 
        matchers = {'matcher_head'},
        forceCompletionPattern = '\\.|:|->|"\\w+/*',
				timeout = 500,
      },
      -- ['copilot'] = {
      --  mark = 'copilot',
      --  matchers = {},
      --  minAutoCompleteLength = 0,
      -- },
    })
    vim.g.copilot_no_maps = true
    
    require("ddc_source_lsp_setup").setup()
    lspconfig = require("lspconfig")
    lspconfig.denols.setup({
      root_dir = lspconfig.util.root_pattern("deno.json"),
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
    })
    lspconfig.tsserver.setup({
      root_dir = lspconfig.util.root_pattern("package.json"),
    })
    
    lspconfig.gopls.setup({
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
        },
      },
    })
    
    require("lspconfig").zls.setup({})
    
    require("lspconfig").perlnavigator.setup({
      cmd = {vim.fn.expand('$HOME/bin/perlnavigator'), '--stdio'},
      settings = {
        perlnavigator = {
          perlPath = vim.fn.expand("$HOME/.plenv/shims/perl"),
        },
      },
    })

    require'lspconfig'.volar.setup{
      filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
      init_options = {
        typescript = {
          tsdk = vim.fn.expand('$HOME/.nodebrew/current/lib/node_modules/typescript/lib')
        }
      }
    }
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
  end,
}
