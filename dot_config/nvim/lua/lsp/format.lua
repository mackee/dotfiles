local M = {}

---@param bufnr integer
---@param client vim.lsp.Client
---@param kind string  LSP CodeActionKind, e.g. "source.organizeImports"
local function apply_code_action_sync(bufnr, client, kind)
  local enc = client.offset_encoding or 'utf-16'
  local params = vim.lsp.util.make_range_params(0, enc)
  params.context = { only = { kind }, diagnostics = {} }
  local resp = client:request_sync('textDocument/codeAction', params, 3000, bufnr)
  if not resp or not resp.result then return end
  for _, action in ipairs(resp.result) do
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit, enc)
    end
    if type(action.command) == 'table' then
      local ok, err = pcall(client.exec_cmd, client, action.command, { bufnr = bufnr })
      if not ok then
        vim.notify(
          ('lsp save action %s: exec_cmd failed: %s'):format(kind, err),
          vim.log.levels.WARN
        )
      end
    end
  end
end

---@param bufnr integer
function M.run_on_save(bufnr)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    local actions = client.config and client.config.on_save_actions
    if actions then
      for _, kind in ipairs(actions) do
        if kind == 'format' then
          vim.lsp.buf.format({
            async = false,
            bufnr = bufnr,
            id = client.id,
            timeout_ms = 3000,
          })
        else
          apply_code_action_sync(bufnr, client, kind)
        end
      end
    end
  end
end

return M
