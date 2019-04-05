export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git pip zsh-completions)
fpath=($ZSH/custom/plugins/zsh-completions/src $fpath)

ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/.oh-my-zsh-cache"
mkdir -p "$ZSH_CACHE_DIR"

autoload -Uz compinit promptinit colors
source $ZSH/oh-my-zsh.sh
compinit
promptinit
colors

bindkey -v
bindkey '^r' history-incremental-search-backward
typeset -g -A key
#terminal
bindkey ';5D' backward-word
bindkey ';5C' forward-word
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line
bindkey '\e[3' delete-char
#konsola
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Delete]=${terminfo[kdch1]}
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    vi-beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     vi-end-of-line
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char

alias ls="ls --color"
alias fanfary="play ~/alarm.ogg > /dev/null 2> /dev/null"
alias free='free -h'

function git-readd()
{
    git diff "${1}~" "${1}" | git apply
}

function mkcd()
{
    mkdir -p "$1"
    cd "$1"
}

PROMPT="%{$bg[green]$fg[black]%} %~ %{$reset_color%}    %T %(?::%{$fg[yellow]%}%?%{$reset_color%})
"
PS2="+= "

function zle-line-init zle-keymap-select {
	local vimode="${${KEYMAP/vicmd/[NORMAL]}/main/[INSERT]}"
	PROMPT="%{$bg[green]$fg[black]%} %~ %{$reset_color%} %(?::%{$fg[yellow]%}%?%{$reset_color%}) ${(l:8:: :)vimode}
"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

setopt appendhistory autocd beep histignorealldups histignorespace
unsetopt share_history
