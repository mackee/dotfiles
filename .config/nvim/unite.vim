let mapleader = ","
noremap [unite] <Nop>
map     <Leader>u [unite]

nnoremap <silent>[unite]p :<C-u>Unite file_rec/async<CR>
nnoremap <silent>[unite]g :<C-u>Unite ghq<CR>
