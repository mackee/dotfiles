filetype on
filetype indent on
filetype plugin on
syntax on
set expandtab
set ts=4
set shiftwidth=4
set smartindent

set fdc=0

let php_folding=0
au Syntax php set fdm=syntax

autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

"filetype
" coffee scirpt
au BufRead,BufNewFile *.coffee set filetype=coffee
" coffee scirpt with vows test
au BufRead,BufNewFile *_spec.coffee set filetype=coffee.vows
" jade
au BufRead,BufNewFile *.jade set filetype=jade
" jade
au BufRead,BufNewFile *.styl set filetype=stylus
" less
au! BufRead,BufNewFile *.less set filetype=less
" sass
au! BufRead,BufNewFile *.sass set filetype=sass
" pytest
au! BufRead,BufNewFile test_*.py set filetype=python.pytest
" prove
au! BufRead,BufNewFile *.t set filetype=perl.prove
" perl
au! BufRead,BufNewFile *.psgi set filetype=perl
au! BufRead,BufNewFile *.t set filetype=perl

" 読み込み時は自動コンパイル設定していないので下記変数を定義
let g:less_autocompile=1

function! GetStatusEx()
  let str = ''
  if &ft != ''
    let str = str . '[' . &ft . ']'
  endif
  if has('multi_byte')
    if &fenc != ''
      let str = str . '[' . &fenc . ']'
    elseif &enc != ''
      let str = str . '[' . &enc . ']'
    endif
  endif
  if &ff != ''
    let str = str . '[' . &ff . ']'
  endif
  return str
endfunction
set statusline=%<%f\ %m%r%h%w%=%{GetStatusEx()}\ \ %l,%c%V%8P

"----------------------------------------------------------
" vim-quickrun
" @see http://d.hatena.ne.jp/ruedap/20110225/vim_php_phpunit_quickrun
"----------------------------------------------------------                                                                                                                                      
augroup QuickRunPHPUnit
  autocmd!
  autocmd BufWinEnter,BufNewFile *test.php set filetype=php.unit
  autocmd BufWinEnter,BufNewFile *Test.php set filetype=php.unit
augroup END
" 初期化
let g:quickrun_config = {}
"let g:quickrun_config._ = {'runner': 'vimproc:100'}
" PHPUnit
let g:quickrun_config['php.unit'] = {'command': 'phpunit'}
let g:quickrun_config['phpunit'] = {'command': 'phpunit'}
" CoffeeScript
let g:quickrun_config['coffee'] = {'command': 'coffee'}
" CoffeeScript with vows
let g:quickrun_config['coffee.vows'] = {
      \ 'exec'    : "%c %o %s %a | sed -e 's/\e\[[0-9]*m//g'",
      \ 'command' : 'vows',
      \ 'args'    : '--spec'
      \}
" CoffeeScript
let g:quickrun_config['jade'] = {'command': 'jade'}
" nodejs
let g:quickrun_config['nodejs'] = {'command': 'node'}
" stylus
let g:quickrun_config['stylus'] = {'command': 'stylus'}
" python
let g:quickrun_config['python'] = {
      \ 'command': 'python',
      \ 'runmode': 'async:remote:vimproc'
      \ }
" pytest
let g:quickrun_config['python.pytest'] = {
    \ 'command' : 'py.test',
    \ 'args'    : '-v'
    \}

" prove
let g:quickrun_config['perl.prove'] = {
    \ 'command' : 'prove',
    \ 'args'    : '-vlr'
    \ }

" perl
let g:quickrun_config['perl'] = {'command': 'perl'}

autocmd BufNewFile,BufRead *.ctp set filetype=php

" カーソル行をハイライト
set cursorline
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=4 guibg=black

" キーマップリーダー
let QFixHowm_Key = 'g'

" howm_dirはファイルを保存したいディレクトリを設定
let howm_dir             = '~/howm'
let howm_filename        = '%Y/%m/%Y-%m-%d-%H%M%S.txt'
let howm_fileencoding    = 'utf-8'
let howm_fileformat      = 'unix'

" vundle
set nocompatible
filetype off
 
set rtp+=~/.vim/neoundle.vim/
if has("vim_starting")
    set runtimepath+=~/.vim/neobundle.vim
    call neobundle#rc(expand('~/.vim/bundle'))
endif
 
" github/vim-scripts
"NeoBundle 'grep.vim'
"NeoBundle 'QuickBuf'
"NeoBundle 'errormarker.vim'
NeoBundle 'wombat256.vim'
NeoBundle 'jnurmine/Zenburn'
NeoBundle 'altercation/vim-colors-solarized'
"NeoBundle 'ref.vim'
"NeoBundle 'open-browser.vim'

" github
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimfiler'

NeoBundle 'gurisugi/microtemplate.vim'

"NeoBundle 'kien/ctrlp.vim'
NeoBundle 'kchmck/vim-coffee-script'
"NeoBundle 'statianzo/vim-jade'
NeoBundle 'thinca/vim-quickrun'
"NeoBundle 'wavded/vim-stylus'
"NeoBundle 'mattn/gist-vim'
NeoBundle 'plasticboy/vim-markdown'
"NeoBundle 'motemen/xslate-vim'
 
"NeoBundle 'toritori0318/vim-redmine'
NeoBundle 't9md/vim-textmanip'
"NeoBundle 'kana/vim-tabpagecd'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-indent'

"NeoBundle 'mattn/webapi-vim'
"NeoBundle 'basyura/unite-yarm'


"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'pix/vim-align'
"NeoBundle 'mileszs/ack.vim'

NeoBundle 'h1mesuke/unite-outline'

NeoBundle 'soh335/vim-perl', 'feature/customize-braceclass-max-indent'

"NeoBundle 'scrooloose/syntastic'

NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'osyo-manga/vim-watchdogs'

"NeoBundle 'thinca/vim-localrc'

NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'tpope/vim-surround'

NeoBundle 'Lokaltog/vim-powerline', 'develop'

"textmanip
xmap <Space>d <Plug>(textmanip-duplicate-down)
nmap <Space>d <Plug>(textmanip-duplicate-down)
xmap <Space>D <Plug>(textmanip-duplicate-up)
nmap <Space>D <Plug>(textmanip-duplicate-up)

xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)

map ,pt <Esc>:%! perltidy -se<CR>
map ,ptv <Esc>:'<,'>! perltidy -se<CR>
map ,u <Esc>:Unite outline

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

 " Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Select with <TAB>
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

let g:neocomplcache_ctags_arguments_list = {
  \ 'perl' : '-R -h ".pm"'
  \ }

if !exists("g:neosnippet#snippets_directory")
    let g:neosnippet#snippets_directory = "~/.vim/snippets"
endif

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" for snippets
imap <S-TAB> <Plug>(neosnippet_jump_or_expand)
smap <S-TAB> <Plug>(neosnippet_jump_or_expand)

" unite-yarm
let g:unite_yarm_server_url = 'https://project.kayac.com/redmine'
let g:unite_yarm_access_key = '729f3e6d05b188108be6af7131eb3ec15b2d25ea'
let g:unite_yarm_limit = 25
let g:unite_yarm_backup_dir = '/tmp/yarm'

set t_Co=256
"colorschem wombat256mod
set number

filetype plugin indent on
set laststatus=2

set tags=tags
set autoread

set fileencoding=utf8

" ずれない
if exists('&ambiwidth')
    set ambiwidth=double
endif

" perl indent level
let g:perl_braceclass_max_indent_level = 1

" clipboard
set clipboard+=unnamed

" vimshell
let g:vimshell_editor_command = '/usr/local/bin/vim'

if filereadable(expand('./.vimrc.local'))
    source ./.vimrc.local
endif

" perl関係
"let g:syntastic_perl_efm_program = "perl ~/.vim/perlcheck.pl"
"let g:vimfiler_safe_mode_by_default = 0
function! s:get_package_name()
    let mx = '^\s*package\s\+\([^ ;]\+\)'
    for line in getline(1, 5)
        if line =~ mx
        return substitute(matchstr(line, mx), mx, '\1', '')
        endif
    endfor
    return ""
endfunction

function! s:check_package_name()
    let path = substitute(expand('%:p'), '\\', '/', 'g')
    let name = substitute(s:get_package_name(), '::', '/', 'g') . '.pm'
    if path[-len(name):] != name
        echohl WarningMsg
        echomsg "ぱっけーじめいと、ほぞんされているぱすが、ちがうきがします！"
        echomsg "ちゃんとなおしてください＞＜"
        echohl None
    endif
endfunction

au! BufWritePost *.pm call s:check_package_name()
function! s:pm_template()
    let path = substitute(expand('%'), '.*lib/', '', 'g')
    let path = substitute(path, '[\\/]', '::', 'g')
    let path = substitute(path, '\.pm$', '', 'g')

    call append(0, 'package ' . path . ';')
    call append(1, 'use strict;')
    call append(2, 'use warnings;')
    call append(3, 'use utf8;')
    call append(4, 'use 5.012;')
    call append(5, '')
    call append(6, '')
    call append(7, '')
    call append(8, '1;')
    call cursor(8, 0)
    " echomsg path
endfunction

autocmd BufNewFile *.pm call s:pm_template()

autocmd BufNewFile *.pl 0r $HOME/.vim/template/perl-script.tmpl
autocmd BufNewFile *.t  0r $HOME/.vim/template/perl-test.tmpl

"powerline
set guifont=Ricty-Regular-Powerline
let g:Powerline_symbols='fancy'
"let g:Powerline_theme='solarized256'
"let g:Powerline_colorscheme='solarized256'
let g:solarized_termcolors=256
colorscheme wombat256mod

" watchdog.vim"
let watchdogs_check_BufWritePost_enable = 1
let g:quickrun_config["watchdogs_checker/_"] = {
\   "hook/close_quickfix/enable_exit" : 1,
\   "runner/vimproc/updatetime" : 40    
\}
let g:quickrun_config["watchdogs_checker/perl-projectlibs"] = {
\   "command" : "perl",
\   "exec" : "%c %o -cw -MProject::Libs %s:p",
\   "quickfix/errorformat": "%m\ at\ %f\ line\ %l%.%#",
\}
let g:quickrun_config["perl/watchdogs_checker"] = {
\   "type": "watchdogs_checker/perl-projectlibs",
\}

call watchdogs#setup(g:quickrun_config)
