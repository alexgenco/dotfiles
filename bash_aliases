alias la='ls -lath'

if [ -e /Applications/MacVim.app ]; then
  alias mvim='/usr/local/bin/mvim > /dev/null'
  alias vi='/Applications/MacVim.app/Contents/MacOS/Vim'
  alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
fi

if [ -e /Applications/Minecraft ]; then
  alias minec='open /Applications/Minecraft'
fi

if [ -d ~/dev/castle ]; then
  alias cas='cd ~/dev/castle'
  alias cons='cd ~/dev/castle && rails c'
fi

if [ -f /usr/local/Cellar/clisp/2.49/bin/clisp ]; then
  alias clisp='/usr/local/Cellar/clisp/2.49/bin/clisp'
fi

alias startpg='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias stoppg='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

alias be='bundle exec'

alias ogre='git checkout ogre'
alias dev='git checkout godfather_dev; git pull'
alias staging='git checkout godfather_staging; git pull'
alias production='git checkout godfather_production; git pull'

alias c='cat ~/.cci'

alias ssbs='open vnc://GFBuildServer.local'
