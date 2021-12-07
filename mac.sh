#!/bin/sh
set -eu

# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
setup_base() {
  brew install wget
  brew install tree
  brew install zsh
  brew install tig
  brew install peco
  brew install direnv
}

setup_app() {
  brew install hyper
  brew install firefox
  brew install google-chrome
  brew install visual-studio-code
  brew install bitwarden
  brew install slack
  brew install insomnia
  brew install boostnote
}

setup_option() {
  brew install fzf
  brew install kube-ps1
  brew install kubectx
  brew install aws-iam-authenticator

  brew install --cask docker
  brew install --cask 1password
}

setup_base
setup_app
setup_option
