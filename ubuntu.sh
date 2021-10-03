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

  sudo snap install ngrok

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

  sudo snap install code --classic
  sudo snap install insomnia
  # sudo snap install bitwarden
  sudo snap install discord
}

setup_fcitx() {
  sudo apt install -y fcitx-mozc

  # Setting -> Language and Regionのmanage installed languagesからIM Systemをfcitxにしておく
  # https://kinakoankon.net/ubuntu-20-04-japanese-input-ibus-fcitx-mozc/
}

# setup_slack() {
#   Download AppImage
#   https://www.appimagehub.com/p/1422594/
#
#   or install with deb
#   sudo apt update && sudo apt install -y gdebi
#   gdebi [slack.deb]
# }

setup_docker() {
  # https://okadahiroshi.hatenablog.com/entry/2018/10/20/141058
  # https://github.com/docker-archive/docker-snap/issues/1
  # sudo groupadd docker
  # sudo usermod -aG docker $USER
  # sudo snap install docker
  sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io

  sudo usermod -aG docker $USER
}

setup_base
setup_app
setup_fcitx
setup_docker

LANG=C xdg-user-dirs-gtk-update
