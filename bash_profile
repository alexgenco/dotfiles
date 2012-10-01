if [ -e ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

if [ -e ~/.git-completion ]; then
  source ~/.git-completion
  GIT_PS1_SHOWDIRTYSTATE="true"
  #PS1='\[\033[33;1m\]\W\[\033[m\]\[\033[1;32m\]$(__git_ps1 "|%s")\[\033[m\]\[\033[1;34m\]\$\[\033[m\] '
  PS1='\[\033[33;1m\]\W\[\033[m\]\[\033[1;32m\]$(__git_ps1 "|%s")\[\033[m\]\[\033[1;34m\]\$\[\033[m\] '
else
  #PS1='\[\033[33;1m\]\W\[\033[m\] \[\033[1;34m\]\$\[\033[m\] '
  PS1='\[\033[33;1m\]\W\[\033[m\]\[\033[1;34m\]\$\[\033[m\] '
fi

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export EDITOR=vim
export PATH=~/bin:/usr/local/bin:/usr/bin:/usr/local/lib:/usr/local/mysql/lib:/opt/local/bin:/opt/local/sbin:$HOME/.rvm/scripts/rvm:.:$PATH
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

export HISTCONTROL=ignoredups
export HISTFILESIZE=3000

# for access to clojure-contrib library
#export CLASSPATH=$CLASSPATH:/usr/local/Cellar/clojure-contrib/1.2.0

# better history
export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTTIMEFORMAT="%D %T "
export HISTIGNORE="&:ls:exit"
shopt -s histappend

export GOTO_HOME=/Users/agenco/.goto && source $GOTO_HOME/goto.sh

source /usr/local/etc/bash_completion.d/password-store

export JAVA_OPTS="-Xms256m -Xmx512m"
