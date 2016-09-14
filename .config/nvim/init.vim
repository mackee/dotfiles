let g:python3_host_prog = '/usr/local/bin/python3'
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif
let g:deoplete#enable_profile = 1
" Required:
set runtimepath^=$HOME/src/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('~/.config/nvim'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')
call dein#load_toml('~/.config/nvim/plugins.toml', {})

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------

let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme solarized

set clipboard+=unnamedplus

source ~/.config/nvim/deoplete.vim
source ~/.config/nvim/lightline.vim
source ~/.config/nvim/unite.vim

set list
set listchars=tab:>-,trail:.,eol:↲,extends:>,precedes:<,nbsp:%
set number