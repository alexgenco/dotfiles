#!/usr/bin/env bash

set -euxo pipefail

cd "$(dirname "$0")"

brew_install() {
  if ! brew ls --versions "$@" > /dev/null; then
    brew install "$@"
  fi
}

tools() {
  if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  if [ "$(uname)" = "Darwin" ]; then
    defaults -currentHost write -g InitialKeyRepeat -int 15
    defaults -currentHost write -g KeyRepeat -int 1
    defaults -currentHost write -g ApplePressAndHoldEnabled -bool false

    if ! xcode-select --print-path &>/dev/null; then
      xcode-select --install
    fi

    brew_install --cask ghostty
  fi

  brew_install mise
  brew_install ripgrep
  brew_install git
  brew_install nvim
  brew_install stow
  brew_install tmux

  mise --silent install
}

link() {
  stow -t ~ dist
}

unlink() {
  stow -t ~ -D dist
}

case "${1:-install}" in
  install) tools && link ;;
  tools)   tools ;;
  link)    link ;;
  unlink)  unlink ;;
  *) echo "usage: $0 [install|tools|link|unlink]" >&2; exit 1 ;;
esac
