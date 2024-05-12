setlocal expandtab
setlocal ts=2
setlocal sw=2
let b:ale_javascript_eslint_executable = 'estlint_d'
let g:ale_fix_on_save = 1

"autocmd BufWritePre <buffer>
"  \ call execute('LspCodeActionSync source.fixAll.eslint')
"autocmd BufWritePre <buffer>
"  \ call execute('LspDocumentFormatSync')


