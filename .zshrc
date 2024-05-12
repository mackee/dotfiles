export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.plenv/shims:$HOME/.plenv/bin:$PATH
if which plenv > /dev/null; then eval "$(plenv init -)"; fi
export PATH=$HOME/.rbenv/bin:$PATH
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH=$HOME/.pyenv/bin:$PATH
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

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

# branch name

autoload -Uz vcs_info

zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# バージョン管理されているディレクトリにいれば表示，そうでなければ非表示
RPROMPT="%1(v|%F{green}%1v%f|)"

autoload -Uz add-zsh-hook
add-zsh-hook precmd plenv_perl_version
PROMPT=$RED'[- o -] %(!.#.$) '$DEFAULT
RPROMPT=$GREEN'%1(v|%1v|)[perl:${PERL_VERSION}][%~]'$DEFAULT
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

alias mvim="/Applications/MacVim.app/Contents/MacOS/mvim --remote-tab"
alias reply="PERL_RL=Caroline reply"

export PYTHONPATH=/usr/local/Cellar/opencv/2.4.6.1/lib/python2.7/site-packages:$PYTHONPATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
eval "$(direnv hook zsh)"

alias gbp="git branch -l | peco | xargs git checkout"
alias gpc="git pull origin \$(git rev-parse --abbrev-ref HEAD)"

#PATH="/Users/taniwaki-makoto/perl5/bin${PATH:+:${PATH}}"; export PATH;
#PERL5LIB="/Users/taniwaki-makoto/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
#PERL_LOCAL_LIB_ROOT="/Users/taniwaki-makoto/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
#PERL_MB_OPT="--install_base \"/Users/taniwaki-makoto/perl5\""; export PERL_MB_OPT;
#PERL_MM_OPT="INSTALL_BASE=/Users/taniwaki-makoto/perl5"; export PERL_MM_OPT;

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

export PATH="$(readlink $(where perl6) | uniq | perl -pne 's[\.\.][/usr/local]; s[(.*)/bin/perl6][$1/share/perl6/site/bin]'):$PATH"

ghq() {
  if [[ $1 == "look" ]]; then
    local repo_path
    repo_path=$(command ghq list --full-path --exact $2)
    cd ${repo_path}
  else
    command ghq "$@"
  fi
}
#source /Users/taniwaki-makoto/.config/op/plugins.sh
