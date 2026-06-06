#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"

os="$(uname)"

tools() {
  case "$os" in
    Darwin)
      defaults -currentHost write -g InitialKeyRepeat -int 15
      defaults -currentHost write -g KeyRepeat -int 1
      defaults -currentHost write -g ApplePressAndHoldEnabled -bool false

      if ! xcode-select --print-path &>/dev/null; then
        xcode-select --install
      fi
      ;;
    *)
      # Homebrew supports linux, it just requires putting it in PATH, which I
      # haven't gotten around to yet.
      #
      # See: https://docs.brew.sh/Homebrew-on-Linux#requirements
      echo "Can't install for os=$os" >&2
      exit 1
      ;;
  esac

  if ! command -v brew &>/dev/null; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  brew bundle install
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
