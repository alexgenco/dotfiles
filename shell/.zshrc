export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export EDITOR=nvim
export GOPATH="$HOME/go"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

bindkey -e

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

if [ -f ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh

  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
fi

setopt prompt_subst
export PROMPT='%U%{%F{00}%}%D{%H:%M:%S} %3~$(__git_ps1 2>/dev/null) %#%f%u '

if [ -f ~/.aliases ]; then
  source ~/.aliases
fi
