alias la='ls -lath'
alias be='bundle exec'
alias ta='tmux attach'
alias g='git'

if [ -f ~/.bash_aliases.local ]; then
  source ~/.bash_aliases.local
fi
