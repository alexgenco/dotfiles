desc "Symlink all files into $HOME"
task :symlink do
  Dir.glob("*/") do |dir|
    sh "stow #{dir.chomp("/")}"
  end
end
