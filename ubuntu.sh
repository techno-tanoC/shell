#!/bin/bash
set -eu

setup_base() {
  sudo apt update
  sudo apt upgrade -y

  sudo apt install -y tree
  sudo apt install -y vim
  sudo apt install -y zsh
  sudo apt install -y curl
  sudo apt install -y peco
  # chsh -s $(which zsh)
}

setup_app() {
  sudo apt install -y transmission
  sudo apt install -y virtualbox
  sudo apt install -y vlc
  sudo apt install -y spacefm
  sudo apt install -y gnome-tweak-tool
  sudo apt install -y snapd
  sudo apt install -y xsel

  snap install slack --classic
  snap install code --classic
  snap install bitwarden
  snap install discord
}

setup_chrome() {
  sudo apt install -y chrome-gnome-shell

  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  rm google-chrome-stable_current_amd64.deb
}

setup_fcitx() {
  sudo apt install -y fcitx-mozc

  # Setting -> Language and Regionのmanage installed languagesからIM Systemをfcitxにしておく
  # https://kinakoankon.net/ubuntu-20-04-japanese-input-ibus-fcitx-mozc/
}

setup_docker() {
  sudo apt install -y docker docker-compose
  sudo usermod -aG docker $USER
}

setup_gcloud() {
  snap install google-cloud-sdk --classic
}

setup_base
setup_app
# setup_chrome
setup_fcitx
setup_docker
setup_gcloud

LANG=C xdg-user-dirs-gtk-update
