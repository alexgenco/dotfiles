alias la='ls -lath'
alias be='bundle exec'
alias g='git'
alias gs='git status'
alias nv='(cd ~/.wiki && vim +NV!)'

if [ -f ~/.bash_aliases.local ]; then
  source ~/.bash_aliases.local
fi
