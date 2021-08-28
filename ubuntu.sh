#!/bin/bash
set -eu

setup_base() {
  sudo apt update
  sudo apt upgrade -y

  sudo apt install -y vim
  sudo apt install -y zsh

  sudo snap install curl
  sudo snap install tree
  sudo snap install peco
  sudo snap install ngrok
  sudo snap install direnv

  # chsh -s $(which zsh)
}

setup_app() {
  sudo apt install -y transmission
  sudo apt install -y virtualbox
  sudo apt install -y spacefm
  sudo apt install -y gnome-tweaks
  sudo apt install -y xsel

  sudo snap install slack --classic
  sudo snap install code --classic
  sudo snap install vlc
  sudo snap install insomnia
  sudo snap install bitwarden
  sudo snap install discord
}

setup_fcitx() {
  sudo apt install -y fcitx-mozc

  # Setting -> Language and Regionのmanage installed languagesからIM Systemをfcitxにしておく
  # https://kinakoankon.net/ubuntu-20-04-japanese-input-ibus-fcitx-mozc/
}

setup_docker() {
  sudo snap install docker
  sudo usermod -aG docker $USER
}

setup_base
setup_app
setup_fcitx
setup_docker

LANG=C xdg-user-dirs-gtk-update
