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
#zle -N predict-on
#zle -N predict-off
bindkey '^xp' predict-on
bindkey '^x^p' predict-off
zstyle ':predict' toggle true
zstyle ':predict' verbose true

export LANG=ja_JP.UTF-8

local GREEN=$'%{\e[1;32m%}'
local BLUE=$'%{\e[1;34m%}'
local RED=$'%{\e[1;36m%}'
local DEFAULT=$'%{\e[1;m%}'
# plenv


local PERL_VERSION=''
plenv_perl_version() {
    local dir=$PWD

    [[ -n $PLENV_VERSION ]] && { echo $PLENV_VERSION; return }

    while [[ -n $dir && $dir != "/" && $dir != "." ]]; do
        if [[ -f "$dir/.perl-version" ]]; then
            PERL_VERSION=`head -n 1 "$dir/.perl-version"`
            return
        fi
        dir=$dir:h
    done

    local plenv_home=$PLENV_HOME
    [[ -z $PLENV_HOME && -n $HOME ]] && plenv_home="$HOME/.plenv"

    if [[ -f "$plenv_home/version" ]]; then
        PERL_VERSION=`head -n 1 "$plenv_home/version"`
        return
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd plenv_perl_version
PROMPT=$RED'[- o -] %(!.#.$) '$DEFAULT
RPROMPT=$GREEN'[perl:${PERL_VERSION}][%~]'$DEFAULT
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
