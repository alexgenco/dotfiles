if [ -e ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

if [ -e ~/.git-completion ]; then
  source ~/.git-completion
  GIT_PS1_SHOWDIRTYSTATE="true"
  PS1='\[\e[2;37m\]\u:\W$(__git_ps1 "(%s)")\$\[\e[0m\] '
else
  PS1='\[\e[2;37m\]\u:\W\$\[\e[0m\] '
fi

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export EDITOR=vim

# put in .bash_profile.local
#export PATH=~/bin:/usr/local/bin:/usr/bin:/usr/local/lib:/usr/local/mysql/lib:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:.:$PATH

# put in .bash_profile.local
#export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

# better history
export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTTIMEFORMAT="%D %T "
export HISTIGNORE="&:ls:exit"
export PROMPT_COMMAND='history -a'
shopt -s histappend

# put in .bash_profile.local
#if [ -d ~/.goto ]; then
#  export GOTO_HOME=/Users/agenco/.goto
#  source $GOTO_HOME/goto.sh
#fi

# put in .bash_profile.local
#if [ -f /usr/local/etc/bash_completion.d/password-store ]; then
#  source /usr/local/etc/bash_completion.d/password-store
#fi

[[ -f ~/.secrets ]] && source ~/.secrets
[[ -f ~/.bash_profile.local ]] && source ~/.bash_profile.local

### Added by the Heroku Toolbelt
# put in .bash_profile.local
#export PATH="/usr/local/heroku/bin:$PATH"
