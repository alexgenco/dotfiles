require "open-uri"
require "rbconfig"
require "shellwords"

HOME = Dir.home.shellescape

def dep(exec, shell = "command -v #{exec} > /dev/null")
  system(*shell) || yield($?.exitstatus)
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
  when /linux/
    dep("apt-get", ["sudo", "apt-get", "update"]) do |status|
      exit status
    end

    dep("git") do
      sh "sudo apt-get install git-core"
    end

    dep("stow") do
      sh "sudo apt-get install stow"
    end

    dep("htop") do
      sh "sudo apt-get install htop"
    end
  else
    warn "Don't know how to install dependencies on this platform. " \
      "You may need to install them manually."
    next
  end

  dep("rbenv") do
    sh "git clone https://github.com/sstephenson/rbenv.git ~/.rbenv"
    sh "git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build"
  end

  dep("fzf") do
    sh "git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf"
    sh "~/.fzf/install"
  end

  dep("ruby", "~/.rbenv/bin/rbenv versions | grep -q -F 2.5.1") do
    sh "~/.rbenv/bin/rbenv install 2.5.1"
  end
end

desc "Symlink all files into $HOME and install vim plugins"
task :install => :deps do
  Dir.glob("*/") do |dir|
    sh "stow -t #{HOME} #{dir.shellescape}"
  end
end

desc "Remove all symlinks from $HOME and uninstall vim plugins"
task :uninstall do
  Dir.glob("*/") do |dir|
    sh "stow -t #{HOME} -D #{dir.shellescape}"
  end

  sh "rm -vrf #{HOME}/.vim/plugged"
end
