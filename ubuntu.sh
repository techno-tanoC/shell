#!/bin/bash
set -eu

setup_base() {
  sudo apt update
  sudo apt upgrade -y

  sudo apt install -y vim
  sudo apt install -y zsh
  sudo apt install -y curl
  sudo apt install -y tree
  sudo apt install -y direnv
  sudo apt install -y peco
  sudo apt install -y ranger

  # chsh -s $(which zsh)
}

setup_app() {
  sudo apt install -y transmission
  sudo apt install -y vlc
  sudo apt install -y virtualbox
  sudo apt install -y spacefm
  sudo apt install -y gnome-tweaks
  sudo apt install -y xsel
  sudo apt install -y dconf-editor
  sudo apt install -y cifs-utils
}

setup_fcitx() {
  sudo apt install -y fcitx-mozc

  # Setting -> Language and Regionのmanage installed languagesからIM Systemをfcitxにしておく
  # https://kinakoankon.net/ubuntu-20-04-japanese-input-ibus-fcitx-mozc/
}

setup_base
setup_app
setup_fcitx

LANG=C xdg-user-dirs-gtk-update
