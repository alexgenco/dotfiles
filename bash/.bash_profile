PS1='\[\033[4m\]\u@\h:\W\[\033[0m\]$ '

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export EDITOR=vim
export HISTCONTROL=erasedups
export HISTFILESIZE=10000
export HISTSIZE=10000
export HISTTIMEFORMAT="%D %T "
export HISTIGNORE="&:ls:exit"
export GOPATH="$HOME/.go"
export PIP_REQUIRE_VIRTUALENV=true

export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.go/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

shopt -s histappend
shopt -s cmdhist

eval "$(rbenv init -)"

if [ -e ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

if [ -f ~/.bash_profile.local ]; then
  source ~/.bash_profile.local
fi
