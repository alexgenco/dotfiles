test -e ~/.bash_aliases && source ~/.bash_aliases

function __jobs_info {
  local active_jobs=`jobs | wc -l | tr -d ' '`
  test $active_jobs != "0" && echo "[$active_jobs]"
}

PS1='\[\033[4m\]\u@\h:\w\[\033[0m\]$ '

if [ -e ~/.git-completion ]; then
  source ~/.git-completion
fi

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx # Dark background
export EDITOR=vim
export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTTIMEFORMAT="%D %T "
export HISTIGNORE="&:ls:exit"
export PROMPT_COMMAND='history -a'
shopt -s histappend
# Save multi-line commands as one command
shopt -s cmdhist

test -f ~/.bash_profile.local && source ~/.bash_profile.local

export PATH="$HOME/.rbenv/bin:$HOME/bin:/usr/local/bin:$PATH"
eval "$(rbenv init -)"

#test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
