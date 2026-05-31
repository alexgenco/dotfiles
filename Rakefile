require "rbconfig"

Dir.chdir File.expand_path(__dir__)

def macos?
  RbConfig::CONFIG["host_os"].match?(/(darwin|mac os)/)
end

desc "Setup dev tools"
task :tools do
  filter = ENV.key?("only") ? ENV["only"].split(",") : [/.*/]
  forced = ENV.fetch("force", "").split(",")

  [
    {
      name: "macos key repeat",
      platform: :macos,
      test: "test `defaults -currentHost read -g KeyRepeat` = 1",
      install: -> {
        sh "defaults -currentHost write -g InitialKeyRepeat -int 15"
        sh "defaults -currentHost write -g KeyRepeat -int 1"
        sh "defaults -currentHost write -g ApplePressAndHoldEnabled -bool false"
      }
    },
    {
      name: "xcode-select",
      platform: :macos,
      test: "xcode-select --print-path > /dev/null",
      install: "xcode-select --install"
    },
    {
      name: "brew",
      install: '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    },
    {
      name: "bash completion",
      test: "test -f $(brew --prefix)/etc/bash_completion",
      install: "brew install bash-completion"
    },
    {
      name: "ripgrep",
      test: "command -v rg > /dev/null",
    },
    {
      name: "ghostty",
      platform: :macos,
      install: "brew install ghostty --cask",
    },
    {
      name: "coreutils",
      platform: :macos,
      test: "brew leaves -r | fgrep -xq coreutils",
    },
    :git,
    :mise,
    {
      name: "mise install",
      test: "test -z \"$(mise ls --missing --no-header --silent)\"",
      install: "mise install",
    },
    {
      name: "bundler",
      install: "gem install bundler",
    },
    {
      name: "gopls",
      install: "go install golang.org/x/tools/gopls@latest",
    },
    :nvim,
    :stow,
    :tmux,
  ].each do |entry|
    opts = entry.is_a?(Symbol) ? { name: entry.to_s } : entry
    name = opts[:name].to_s
    test = opts.fetch(:test) { "command -v #{name} > /dev/null" }
    install = opts.fetch(:install) { "brew install #{name}" }
    next if filter.none? { |pat| pat === name }
    next if opts[:platform] == :macos && !macos?

    sh(test) do |ok, _|
      next if ok && !forced.include?(name)
      case install
      when String
        sh(install)
      when Proc
        install.call
      end
    end
  end
end

desc "Symlink files into $HOME"
task :link do
  sh "stow -t ~ dist"
end

desc "Remove symlinks from $HOME"
task :unlink do
  sh "stow -t ~ -D dist"
end

desc "Install dependencies and dotfiles"
task install: [:tools, :link]

desc "Uninstall dotfiles"
task uninstall: [:unlink]

task default: :install
