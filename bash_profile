test -e ~/.bash_aliases && source ~/.bash_aliases

function __jobs_info {
  local active_jobs=`jobs | wc -l | tr -d ' '`
  test $active_jobs != "0" && echo "[$active_jobs]"
}

if [ -e ~/.git-completion ]; then
  source ~/.git-completion
  GIT_PS1_SHOWDIRTYSTATE="true"
  PS1='\u:\W$(__git_ps1 "(%s)")$(__jobs_info)\$ '
else
  PS1='\u:\W$(__jobs_info)\$ '
fi

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export EDITOR=vim

# better history
export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTTIMEFORMAT="%D %T "
export HISTIGNORE="&:ls:exit"
export PROMPT_COMMAND='history -a'
shopt -s histappend

test -f ~/.bash_profile.local && source ~/.bash_profile.local

export PATH="$HOME/.rbenv/bin:$HOME/bin:/usr/local/bin:$PATH"
eval "$(rbenv init -)"
