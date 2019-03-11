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

export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

shopt -s histappend
shopt -s cmdhist

PROMPT_DIRTRIM=2

if [ -f ~/.git-prompt.sh ]; then
  . ~/.git-prompt.sh

  export GIT_PS1_SHOWDIRTYSTATE=1
  export GIT_PS1_SHOWUNTRACKEDFILES=1
  export GIT_PS1_SHOWCOLORHINTS=1
else
  alias __git_ps1=:
fi

export PS1='\[\e[2m\]$(date +"%H:%M:%S") \w$(__git_ps1) $\[\e[0m\] '

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
