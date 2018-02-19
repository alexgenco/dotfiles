require "open-uri"
require "rbconfig"

desc "Symlink all files into $HOME and install vim plugins"
task :install => :deps do
  Dir.glob("*/") do |dir|
    sh "stow", "-t", Dir.home, dir
  end
end

desc "Remove all symlinks from $HOME and uninstall vim plugins"
task :uninstall do
  Dir.glob("*/") do |dir|
    sh "stow", "-t", Dir.home, "-D", dir
  end

  sh "rm", "-v", "-r", "-f", File.join(Dir.home, ".vim/plugged")
end

desc "Install dependencies"
task :deps do
  dep("brew") do
    case RbConfig::CONFIG["host_os"]
    when /(darwin|mac os)/
      open("https://raw.githubusercontent.com/Homebrew/install/master/install") do |io|
        Dir.chdir(Dir.pwd) { eval(io.read) }
      end
    when /linux/
      open("https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh") do |io|
        system("/bin/sh", "-c", io.read)
      end
    else
      warn "Don't know how to install `brew` on this platform. " +
        "You may need to install dependencies manually."

      next
    end
  end

  dep("bash", check: -> {
    version = %x(bash --version)[Regexp.new(Gem::Version::VERSION_PATTERN)]
    version = Gem::Version.new(version)
    requirement = Gem::Requirement.new("~> 4")

    requirement.satisfied_by?(version)
  }) do
    sh "brew install bash"
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
end

def dep(exec, check: -> { system("command -v #{exec} > /dev/null") })
  check.call || yield
end
