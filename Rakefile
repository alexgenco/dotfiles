desc "Symlink all files into $HOME"
task :symlink do
  require "shellwords"
  home = Dir.home.shellescape

  Dir.glob("*/") do |dir|
    dir = dir.chomp("/").shellescape
    sh "stow -t #{home} #{dir}"
  end
end
