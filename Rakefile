require "open-uri"
require "rbconfig"
require "shellwords"

def dep(exec)
  system("command -v #{exec} > /dev/null") || yield
end

desc "Install OSX dependencies"
task :osx_deps do
  if RbConfig::CONFIG["host_os"] =~ /(darwin|mac os)/
    dep("brew") do
      open("https://raw.githubusercontent.com/Homebrew/install/master/install") do |io|
        Dir.chdir(Dir.pwd) { eval(io.read) }
      end
    end

    dep("rbenv") do
      sh "brew install rbenv"
    end

    dep("stow") do
      sh "brew install stow"
    end

    dep("fzf") do
      sh "brew install fzf"
    end
  else
    warn "Not installing dependencies on non-OSX. You may need to install them manually."
  end
end

desc "Symlink all files into $HOME and install vim plugins"
task :install => :osx_deps do
  Dir.glob("*/") do |dir|
    sh "stow -t $HOME #{dir.shellescape}"
  end

  sh "vim -E +PlugInstall +qa! > /dev/null"
  sh "vim -c 'silent GoUpdateBinaries' +qa! > /dev/null"
end

desc "Remove all symlinks from $HOME and uninstall vim plugins"
task :uninstall do
  Dir.glob("*/") do |dir|
    sh "stow -t $HOME -D #{dir.shellescape}"
  end

  sh "rm -vrf $HOME/.vim/plugged"
end
