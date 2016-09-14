" Tiny init.vim for deoplete-go

let $XDG_CACHE_HOME = $HOME . '/.cache'
let $XDG_CONFIG_HOME = $HOME . '/.config'

" dein
set runtimepath+=$HOME/src/github.com/Shougo/deoplete.nvim
set runtimepath+=$HOME/src/github.com/zchee/deoplete-go
set completeopt+=noinsert,noselect
set completeopt-=preview

let g:deoplete#auto_completion_start_length = 1

hi Pmenu    gui=NONE    guifg=#c5c8c6 guibg=#373b41
hi PmenuSel gui=reverse guifg=#c5c8c6 guibg=#373b41

call deoplete#custom#set('_', 'converters', [
      \   'converter_auto_paren',
      \   'converter_remove_overlap',
      \ ])
let g:deoplete#sources#go#on_event = 1

let deoplete#sources#go#debug = 1
" deoplete-go
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#package_dot = 1
let g:deoplete#sources#go#json_directory = '~/.cache/deoplete/go/$GOOS_$GOARCH'

filetype plugin indent on
