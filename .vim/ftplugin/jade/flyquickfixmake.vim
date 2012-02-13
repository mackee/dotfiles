""" $HOME/.vim/ftplugin/javascript/flyquickfixmake.vim
""" setting for jade
setlocal makeprg=/usr/local/bin/jade\ %
setlocal errorformat=%A%m:\ %f:%l.%#,%Z%.%#

if !exists("g:jade_flyquickfixmake")
    let g:jade_flyquickfixmake = 1
    au BufWritePost *.jade make
endif
