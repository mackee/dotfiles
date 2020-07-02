autocmd BufWritePre <buffer>
  \ call execute('LspCodeActionSync source.organizeImports')
