return {
  setup = function()
    ---@param client vim.lsp.Client
    ---@param bufnr integer
    ---@param cmd string
    local function code_action_sync(client, bufnr, cmd)
      -- https://github.com/golang/tools/blob/gopls/v0.11.0/gopls/doc/vim.md#imports
      local params = vim.lsp.util.make_range_params()
      params.context = { only = { cmd }, diagnostics = {} }
      -- gopls のドキュメントでは `vim.lsp.buf_request_sync` を使っているが、
      -- ここでは対象 Language Server を1つに絞るために `vim.lsp.Client` の `request_sync` を使う
      local res = client.request_sync("textDocument/codeAction", params, 3000, bufnr)
      for cid, r in pairs(res and res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end

    ---@param client vim.lsp.Client
    ---@param bufnr integer
    local function organize_imports_sync(client, bufnr)
      code_action_sync(client, bufnr, "source.organizeImports")
    end

    ---@param client vim.lsp.Client
    ---@param bufnr integer
    local function fix_all_sync(client, bufnr)
      code_action_sync(client, bufnr, "source.fixAll")
    end

    ---@param client vim.lsp.Client
    ---@param bufnr integer
    local function format_sync(client, bufnr)
      _ = client
      vim.lsp.buf.format({ async = false, bufnr = bufnr })
    end

    ---@type table<string, fun(client: vim.lsp.Client, bufnr: integer)[]>
    local save_handlers_by_client_name = {
      gopls = { organize_imports_sync, format_sync },
      biome = { fix_all_sync, organize_imports_sync, format_sync },
      lua_ls = { format_sync },
    }

    vim.api.nvim_create_autocmd("BufWritePre", {
      ---@param args { buf: integer }
      callback = function(args)
        local bufnr = args.buf
        local shouldSleep = false
        for _, client in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
          local save_handlers = save_handlers_by_client_name[client.name]
          for _, f in pairs(save_handlers or {}) do
            if shouldSleep then
              vim.api.nvim_command("sleep 10ms")
            else
              shouldSleep = true
            end
            f(client, bufnr)
          end
        end
      end,
    })
  end
}
