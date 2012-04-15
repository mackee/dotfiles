# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
setopt autopushd

autoload -U compinit
compinit
autoload predict-on
predict-on

export LANG=ja_JP.UTF-8

local GREEN=$'%{\e[1;32m%}'
local BLUE=$'%{\e[1;34m%}'
local RED=$'%{\e[1;36m%}'
local DEFAULT=$'%{\e[1;m%}'

PROMPT=$RED'[${USER}@%M] %(!.#.$) '$DEFAULT
RPROMPT=$GREEN'[%~]'$DEFAULT
setopt PROMPT_SUBST

bindkey -v

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify

setopt auto_cd
setopt auto_pushd
setopt correct
setopt list_packed

alias mlterm="mlterm -j genuine"

export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

alias ls="ls -G"
alias gls="gls --color"

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

export PATH=/usr/local/bin:$PATH:/usr/local/gae:/usr/local/sbin
export PYTHONPATH=$PATH:/usr/local/gae:/usr/local/gae/lib/antlr3:/usr/local/gae/lib/cacerts:/usr/local/gae/lib/django:/usr/local/gae/lib/ipaddr:/usr/local/gae/lib/webob:/usr/local/gae/lib/yaml/lib

export NODE_PATH=/usr/local/lib/node_modules
export PATH=/usr/local/share/npm/bin:$PATH

source ~/.pythonbrew/etc/bashrc

#export VIRTUALENVWRAPPER_PYTHON=$HOME/.pythonbrew/pythons/Python-2.7.2/bin/python
#source $HOME/.pythonbrew/pythons/Python-2.7.2/bin/virtualenvwrapper.sh
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
source /usr/local/bin/virtualenvwrapper.sh
export PIP_RESPECT_VIRTUALENV=true

source ~/perl5/perlbrew/etc/bashrc

alias gd='dirs -v; echo -n "select number: "; read newdir; cd -"$newdir"'
export PATH=/usr/local/Cellar/ruby/1.9.3-p125/bin/:$PATH

alias tmux='tmux -2'
