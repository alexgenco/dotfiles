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

# better history
export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTTIMEFORMAT="%D %T "
export HISTIGNORE="&:ls:exit"
export PROMPT_COMMAND='history -a'
shopt -s histappend

[[ -f ~/.secrets ]] && source ~/.secrets
[[ -f ~/.bash_profile.local ]] && source ~/.bash_profile.local
