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
" pytest
au! BufRead,BufNewFile test_*.py set filetype=python.pytest
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
let g:quickrun_config._ = {'runner': 'vimproc:100'}
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
let g:quickrun_config['nodejs'] = {'command': 'stylus'}
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
 
set rtp+=~/.vim/vundle/
call vundle#rc()
 
" github/vim-scripts
Bundle "grep.vim"
Bundle "The-NERD-tree"
Bundle "QuickBuf"
Bundle "taglist.vim"
Bundle "errormarker.vim"
Bundle "wombat256.vim"
 
" github
Bundle "Shougo/neocomplcache"
Bundle "tpope/vim-surround"
Bundle "scrooloose/nerdcommenter"
Bundle "kien/ctrlp.vim"
Bundle "kchmck/vim-coffee-script"
Bundle "statianzo/vim-jade"
Bundle "thinca/vim-quickrun"
Bundle "wavded/vim-stylus"
Bundle "Shougo/vimproc"
Bundle "mattn/gist-vim"
Bundle "tpope/vim-markdown"
Bundle "toritori0318/vim-redmine"

set t_Co=256
colorschem wombat256mod
set number

filetype plugin indent on
