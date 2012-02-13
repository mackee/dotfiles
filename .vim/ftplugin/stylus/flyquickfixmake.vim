""" $HOME/.vim/ftplugin/javascript/flyquickfixmake.vim
""" setting for stylus
setlocal makeprg=/usr/local/bin/stylus\ %
setlocal errorformat=%A%f\\,\ line\ %l\\,\ character\ %c:%m,%C%.%#,%Z%.%#

if !exists("g:stylus_flyquickfixmake")
    let g:stylus_flyquickfixmake = 1
    au BufWritePost *.styl make
endif
