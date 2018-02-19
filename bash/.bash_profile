PS1='\[\033[4m\]\u@\h:\W\[\033[0m\]$ '

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

if [ -d /home/linuxbrew/.linuxbrew ]; then
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
  export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
  export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
elif [ -d $HOME/.linuxbrew ]; then
  export PATH="$HOME/.linuxbrew/bin:$PATH"
  export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
  export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
fi
