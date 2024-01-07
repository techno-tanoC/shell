#!/bin/sh
set -eu

# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
setup_cui() {
  brew install wget
  brew install tree
  brew install zsh
  brew install tig
  brew install peco
  brew install direnv
}

setup_gui() {
  brew install --cask firefox
  brew install --cask google-chrome
  brew install --cask visual-studio-code
  brew install --cask bitwarden
  brew install --cask slack
  brew install --cask insomnia
  brew install --cask iterm2
  brew install --cask docker
}

setup_option() {
  brew install fzf
  brew install kube-ps1
  brew install kubectx

  brew install --cask 1password
}

setup_cui
setup_gui
# setup_option
