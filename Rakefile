require "shellwords"

desc "Symlink all files into $HOME"
task :symlink do
  Dir.glob("*/") do |dir|
    sh "stow -t $HOME #{dir.shellescape}"
  end
end

desc "Remove all symlinks from $HOME"
task :unlink do
  Dir.glob("*/") do |dir|
    sh "stow -t $HOME -D #{dir.shellescape}"
  end
end
