require "fileutils"
require "open-uri"
require "rbconfig"
require "shellwords"

Dir.chdir File.expand_path(__dir__)

def dep(exec, shell = "command -v #{exec} > /dev/null")
  deps = ENV.key?("deps") ? ENV["deps"].split(",") : [/.*/]
  return if deps.none? { |pat| pat === exec }

  sh(shell) do |ok, status|
    if !ok || ENV.fetch("force", "").split(",").include?(exec)
      block_given? ? yield : exit(status.exitstatus)
    end
  end
end

def target_dirs(&block)
  ENV.fetch("dirs", "*/")
    .split(",")
    .flat_map { |dir| Dir.glob(dir) }
    .uniq
    .each(&block)
end

def local_bin(executable)
  dir = File.join(Dir.home, ".local/bin")
  exe = File.join(dir, executable)

  FileUtils.mkdir_p(dir)
  yield exe
  FileUtils.chmod("+x", exe)
end

desc "Setup dependencies"
task :setup do
  case RbConfig::CONFIG["host_os"]
  when /(darwin|mac os)/
    dep("keyboard", "test `defaults -currentHost read -g KeyRepeat` = 1") do
      sh "defaults -currentHost write -g InitialKeyRepeat -int 15"
      sh "defaults -currentHost write -g KeyRepeat -int 1"
      sh "defaults -currentHost write -g ApplePressAndHoldEnabled -bool false"
    end

    dep("brew") do
      URI.open("https://raw.githubusercontent.com/Homebrew/install/master/install.sh") do |io|
        sh "bash", "-c", io.read
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

    dep("xcode-select", "xcode-select --print-path > /dev/null") do
      sh "xcode-select --install"
    end

    dep("nvim") do
      sh "brew install --HEAD neovim"
    end

    dep("bash completion", "test -f $(brew --prefix)/etc/bash_completion") do
      sh "brew install bash-completion"
    end

    dep("kitty") do
      sh "brew cask install kitty"
    end

    dep("rust-analyzer") do
      local_bin("rust-analyzer") do |path|
        sh "curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-apple-darwin.gz | " \
          "gunzip > #{path}"
      end
    end

    dep("go") do
      sh "brew install go"
    end

    dep("ripgrep", "command -v rg > /dev/null") do
      sh "brew install ripgrep"
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

    dep("nvim") do
      sh "sudo apt-get install neovim"
    end

    dep("rust-analyzer") do
      local_bin("rust-analyzer") do |path|
        sh "curl https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-musl.gz | " \
          "gunzip > #{path}"
      end
    end

    dep("go") do
      sh "curl -L https://golang.org/dl/go1.16.3.linux-amd64.tar.gz | " \
        "sudo tar xvz -C /usr/local"
    end

    dep("ripgrep", "command -v rg > /dev/null") do
      URI.open("https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb") do |io|
        IO.copy_stream(io, "/tmp/ripgrep.deb")
        io.flush
      end

      sh "sudo dpkg -i /tmp/ripgrep.deb"
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

  dep("ruby", "~/.rbenv/bin/rbenv versions | grep -q -F 2.6.0") do
    sh "~/.rbenv/bin/rbenv install 2.6.0 && ~/.rbenv/bin/rbenv global 2.6.0"
  end

  dep("bundler") do
    sh "~/.rbenv/shims/gem install bundler"
  end

  dep("vim plugins", "nvim -e +PlugInstall +PlugClean +qa!") do
    warn "Failed to install nvim plugins"
  end

  dep("rust", "command -v rustc > /dev/null") do
    sh "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs " \
      "| sh -s -- -y --no-modify-path -c rust-src"
  end

  dep("gopls") do
    sh "PATH=$PATH:/usr/local/go/bin GO111MODULE=on go get golang.org/x/tools/gopls@latest"
  end
end

desc "Symlink files into $HOME"
task :link do
  target_dirs do |dir|
    sh "stow -t ~ --ignore='.*\\.gitkeep' #{dir.shellescape}"
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
task install: [:setup, :link]

desc "Uninstall dotfiles and cleanup"
task uninstall: [:unlink, :cleanup]

task default: :install
