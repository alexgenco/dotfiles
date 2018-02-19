require "open-uri"
require "rbconfig"
require "rubygems"

desc "Symlink all files into $HOME and install vim plugins"
task :install => :deps do
  Dir.glob("*/") do |dir|
    sh "stow", "-t", ENV.fetch("HOME"), dir
  end
end

desc "Remove all symlinks from $HOME and uninstall vim plugins"
task :uninstall do
  Dir.glob("*/") do |dir|
    sh "stow", "-t", ENV.fetch("HOME"), "-D", dir
  end
end

desc "Install dependencies"
task :deps do
  dep(brew) do
    if RbConfig::CONFIG["host_os"] =~ /(darwin|mac os)/
      open("https://raw.githubusercontent.com/Homebrew/install/master/install") do |io|
        Dir.chdir(Dir.pwd) { eval(io.read) }
      end
    elsif RbConfig::CONFIG["host_os"] =~ /linux/ && system("command -v apt-get > /dev/null")
      sh "sudo apt-get install -y build-essential make cmake scons curl git"

      open("https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh") do |io|
        system("/bin/sh", "-c", io.read) || abort("Linuxbrew installation failed.")
      end
    else
      warn "Don't know how to install `brew` on this platform. You may need to install dependencies manually."
      exit 1
    end
  end

  dep("git", ">= 2.2") do
    sh brew, "install", "git"
  end

  dep("bash", "~> 4") do
    sh brew, "install", "bash"
  end

  dep("tmux", ">= 1.9", "-V") do
    sh brew, "install", "tmux"
  end

  dep("rbenv") do
    sh brew, "install", "rbenv"
  end

  dep("stow") do
    sh brew, "install", "stow"
  end

  dep("fzf") do
    sh brew, "install", "fzf"
  end
end

def dep(exec, version_requirement=">= 0", version_flag="--version")
  if system("command -v #{exec} > /dev/null")
    version = %x(#{exec} #{version_flag})[Regexp.new(Gem::Version::VERSION_PATTERN)]
    version = Gem::Version.new(version)
    requirement = Gem::Requirement.new(version_requirement)

    requirement.satisfied_by?(version)
  end || yield
end

def brew
  [
    "/home/linuxbrew/.linuxbrew/bin/brew",
    File.join(ENV.fetch("HOME"), ".linuxbrew/bin/brew")
  ].select { |path| File.exists?(path) }.first || "brew"
end
