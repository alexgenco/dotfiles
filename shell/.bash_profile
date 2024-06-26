export HISTCONTROL=erasedups
export HISTFILESIZE=10000
export HISTSIZE=10000
export HISTTIMEFORMAT="%D %T "
export HISTIGNORE="&:ls:exit"

shopt -s histappend
shopt -s cmdhist

PROMPT_DIRTRIM=2

if [ -f ~/.git-prompt.sh ]; then
  . ~/.git-prompt.sh

  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
fi

if [ -f /usr/local/etc/profile.d/bash_completion.sh ]; then
  source /usr/local/etc/profile.d/bash_completion.sh
fi

if [ -f ~/.local/etc/git-completion.bash ]; then
  source ~/.local/etc/git-completion.bash
fi

export PS1='\[\e[1m\e[4m\]$(date +"%H:%M:%S") \w$(__git_ps1 2>/dev/null) $\[\e[0m\] '

if [ -f ~/.env ]; then
  source ~/.env
fi

if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

if [ -f ~/.cargo/env ]; then
  source ~/.cargo/env
fi

if [ -f ~/.local/etc/bashrc ]; then
  source ~/.local/etc/bashrc
fi

eval "$(rbenv init -)"
