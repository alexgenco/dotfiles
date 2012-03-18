[[ -s "/Users/agenco/.rvm/scripts/rvm" ]] && source "/Users/agenco/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

if [ -f ~/.bash_aliases ]; then
	source ~/.bash_aliases
fi
