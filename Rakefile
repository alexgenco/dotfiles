require "open-uri"
require "rbconfig"
require "shellwords"

Dir.chdir File.expand_path(__dir__)

def dep(exec, shell = "command -v #{exec} > /dev/null")
  sh(shell) do |ok, status|
    if !ok
      block_given? ? yield : exit(status.exitstatus)
    end
  end
end

def target_dirs(&block)
  ENV.fetch("only", "*/")
    .split(",")
    .flat_map { |dir| Dir.glob(dir) }
    .uniq
    .each(&block)
end

desc "Install OSX dependencies"
task :deps do
  case RbConfig::CONFIG["host_os"]
  when /(darwin|mac os)/
    dep("brew") do
      open("https://raw.githubusercontent.com/Homebrew/install/master/install") do |io|
        Dir.chdir(Dir.pwd) { eval(io.read) }
      end
    end

    dep("git") do
      sh "brew install git"
    end

    dep("stow") do
      sh "brew install stow"
    end

    dep("htop") do
      sh "brew install htop"
    end

    dep("tmux") do
      sh "brew install tmux"
    end

    dep("bash completion", "test -f $(brew --prefix)/etc/bash_completion") do
      sh "brew install bash-completion"
    end

    dep("kitty") do
      sh "brew cask install kitty"
    end
  when /linux/
    dep("apt-get", "sudo apt-get update")

    dep("git") do
      sh "sudo apt-get -y install git-core"
    end

    dep("stow") do
      sh "sudo apt-get -y install stow"
    end

    dep("htop") do
      sh "sudo apt-get -y install htop"
    end

    dep("tmux") do
      sh "sudo apt-get -y install libevent-dev libncurses5-dev"
      sh "curl -L https://github.com/tmux/tmux/releases/download/2.8/tmux-2.8.tar.gz | " \
        "sudo tar xvz -C /usr/local/src"

      Dir.chdir("/usr/local/src/tmux-2.8") do
        sh "sudo bash -c './configure && make && make install'"
      end
    end
  else
    abort "Don't know how to install on this platform."
  end

  dep("rbenv", "test -d ~/.rbenv && git -C ~/.rbenv pull") do
    sh "git clone https://github.com/sstephenson/rbenv.git ~/.rbenv"
  end

  dep("ruby-build", "test -d ~/.rbenv/plugins/ruby-build && git -C ~/.rbenv/plugins/ruby-build pull") do
    sh "git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build"
  end

  dep("fzf", "test -f ~/.fzf/bin/fzf") do
    sh "git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf"
    sh "~/.fzf/install --bin"
  end

  dep("ruby", "~/.rbenv/bin/rbenv versions | grep -q -F 2.6.0") do
    sh "~/.rbenv/bin/rbenv install 2.6.0 && ~/.rbenv/bin/rbenv global 2.6.0"
  end

  dep("bundler") do
    sh "~/.rbenv/shims/gem install bundler"
  end

  dep("vim plugins", "vim -e +PlugInstall +PlugClean +qa!") do
    warn "Failed to install vim plugins"
  end
end

desc "Symlink files into $HOME"
task :link do
  target_dirs do |dir|
    sh "stow -t ~ #{dir.shellescape}"
  end
end

desc "Remove symlinks from $HOME"
task :unlink do
  target_dirs do |dir|
    sh "stow -t ~ -D #{dir.shellescape}"
  end
end

desc "Cleanup installed vim plugins"
task :cleanup do
  sh "rm -vrf ~/.vim/plugged"
end

desc "Install dependencies and dotfiles"
task install: [:deps, :link]

desc "Uninstall dotfiles and cleanup"
task uninstall: [:unlink, :cleanup]
