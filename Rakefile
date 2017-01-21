require "shellwords"

desc "Symlink all files into $HOME and install vim plugins"
task :install do
  Dir.glob("*/") do |dir|
    sh "stow -t $HOME #{dir.shellescape}"
  end

  sh "vim +PlugInstall +qa!"
end

desc "Remove all symlinks from $HOME and uninstall vim plugins"
task :uninstall do
  Dir.glob("*/") do |dir|
    sh "stow -t $HOME -D #{dir.shellescape}"
  end

  sh "rm -vrf $HOME/.vim/plugged"
end
