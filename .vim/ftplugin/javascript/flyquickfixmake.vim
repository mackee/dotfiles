""" $HOME/.vim/ftplugin/javascript/flyquickfixmake.vim
""" setting for nodelint
setlocal makeprg=/usr/local/bin/nodelint\ --config\ $HOME/develop/node/nodelint/config.js\ %
setlocal errorformat=%A%f\\,\ line\ %l\\,\ character\ %c:%m,%C%.%#,%Z%.%#

if !exists("g:javascript_flyquickfixmake")
    let g:javascript_flyquickfixmake = 1
    au BufWritePost *.js make
endif
