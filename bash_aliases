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
fi

if [ -f /usr/local/Cellar/clisp/2.49/bin/clisp ]; then
  alias clisp='/usr/local/Cellar/clisp/2.49/bin/clisp'
fi
