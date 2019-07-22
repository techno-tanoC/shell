#!/bin/sh
set -eu

# /usr/bin/ruby -e "`curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install`"
setup_base() {
    brew install tree
    brew install zsh
    brew install fd
    brew install peco
}

setup_app() {
    brew cask install google-chrome
    brew cask install visual-studio-code
    brew cask install virtualbox
    brew cask install bitwarden
}