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

function checkout_and_pull_if_needed {
  local branch=$1
  local changed=0

  git checkout $branch

  [[ `git log $branch..origin/$branch` ]] && changed=1

  [[ $changed == 1 ]] && git pull origin $branch
}

alias ogre='checkout_and_pull_if_needed ogre'
alias dev='checkout_and_pull_if_needed godfather_dev'
alias stage='checkout_and_pull_if_needed godfather_staging'
alias prod='checkout_and_pull_if_needed godfather_production'

alias c='cat ~/.cci'

alias ssbs='open vnc://GFBuildServer.local'

if [ -d /Applications/dungeonosx ]; then
  alias zork='cd /Applications/dungeonosx; dungeon'
fi

function enable_rvm {
  [[ -s "/Users/agenco/.rvm/scripts/rvm" ]] && source "/Users/agenco/.rvm/scripts/rvm"
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
}
alias ervm=enable_rvm

function enable_rbenv {
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
}
alias erbenv=enable_rbenv

alias got='git'
