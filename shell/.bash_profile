export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export EDITOR=vim
export HISTCONTROL=erasedups
export HISTFILESIZE=10000
export HISTSIZE=10000
export HISTTIMEFORMAT="%D %T "
export HISTIGNORE="&:ls:exit"
export GOPATH="$HOME/go"
export PIP_REQUIRE_VIRTUALENV=true
export BASH_SILENCE_DEPRECATION_WARNING=1

export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

shopt -s histappend
shopt -s cmdhist

PROMPT_DIRTRIM=2

if [ -f ~/.git-prompt.sh ]; then
  . ~/.git-prompt.sh

  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
fi

export PS1='\[\e[2m\e[4m\]$(date +"%H:%M:%S") \w$(__git_ps1 2>/dev/null) $\[\e[0m\] '

eval "$(rbenv init -)"

if [ -e ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

if [ -f ~/.bash_profile.local ]; then
  source ~/.bash_profile.local
fi

if [ -f ~/.virtualenv/bin/activate ]; then
  export VIRTUAL_ENV_DISABLE_PROMPT=1
  source ~/.virtualenv/bin/activate
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
