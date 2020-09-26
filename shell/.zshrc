setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY

HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

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
PROMPT='%B%U%D{%H:%M:%S} %3~$(__git_ps1 2>/dev/null) %#%b%u '

if [ -f ~/.env ]; then
  source ~/.env
fi

if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

if [ -f ~/.local/etc/zshrc ]; then
  source ~/.local/etc/zshrc
fi

eval "$(rbenv init - zsh)"
