let g:asyncomplete_auto_popup = 1

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
"\ 'name': 'omni',
"\ 'whitelist': ['*'],
"\ 'blacklist': ['c', 'cpp', 'html'],
"\ 'completor': function('asyncomplete#sources#omni#completor')
"\  }))

call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
\ 'name': 'buffer',
\ 'whitelist': ['*'],
\ 'blacklist': ['go'],
\ 'completor': function('asyncomplete#sources#buffer#completor'),
\ 'config': {
\    'max_buffer_size': 5000000,
\  },
\ }))
