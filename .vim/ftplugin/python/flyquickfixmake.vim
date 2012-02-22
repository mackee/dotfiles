""" $HOME/.vim/ftplugin/python/flyquickfixmake.vim
""" setting for pyflakes
setlocal makeprg=$HOME/.pythonbrew/pythons/Python-2.7.2/bin/pyflakes\ %
setlocal errorformat=%f:%l:%m

if !exists("g:python_flyquickfixmake")
    let g:python_flyquickfixmake = 1
    au BufWritePost *.py make
endif
