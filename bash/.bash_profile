PS1='\[\033[4m\]\u@\h:\w\[\033[0m\]$ '

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx # Dark background
export EDITOR=vim
export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTTIMEFORMAT="%D %T "
export HISTIGNORE="&:ls:exit"
export PROMPT_COMMAND='history -a'

shopt -s histappend
shopt -s cmdhist

export PATH="$HOME/.rbenv/bin:$HOME/bin:$HOME/.cargo/bin:$PATH"
eval "$(rbenv init -)"

if [ -e ~/.git-completion ]; then
  source ~/.git-completion
fi

if [ -e ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

if [ -f ~/.bash_profile.local ]; then
  source ~/.bash_profile.local
fi
