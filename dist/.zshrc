setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt INC_APPEND_HISTORY_TIME
setopt INTERACTIVE_COMMENTS

export HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

bindkey -e

autoload -Uz edit-command-line
autoload -Uz zmv
autoload -Uz compinit
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Only run security audit once a day
if [[ -n ~/.zcompdump(#qNmh-24) ]]; then
  compinit -C
else
  compinit
fi

if [ -f ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh

  export GIT_PS1_SHOWDIRTYSTATE=1
  export GIT_PS1_SHOWUNTRACKEDFILES=1
fi

setopt prompt_subst
export PROMPT='%B%U%D{%H:%M:%S} %3~$(__git_ps1 2>/dev/null) %#%b%u '

if [ -f ~/.cargo/env ]; then
  source ~/.cargo/env
fi

if [ -f ~/.env ]; then
  source ~/.env
fi

if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

if [ -f ~/.local/etc/zshrc ]; then
  source ~/.local/etc/zshrc
fi

if [ -f ~/.local/etc/git-completion.bash ]; then
  zstyle ':completion:*:*:git:*' script ~/.local/etc/git-completion.bash
fi

if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

if [ -f /opt/homebrew/bin/mise ]; then
  eval "$(/opt/homebrew/bin/mise activate zsh)"
fi
