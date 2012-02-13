""" $HOME/.vim/ftplugin/python/flyquickfixmake.vim
""" setting for pyflakes
setlocal makeprg=/usr/local/bin/pyflakes\ %
setlocal errorformat=%f:%l:%m

if !exists("g:python_flyquickfixmake")
    let g:python_flyquickfixmake = 1
    au BufWritePost *.py make
endif
