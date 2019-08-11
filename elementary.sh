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
}

setup_app() {
  sudo apt install -y transmission
  sudo apt install -y virtualbox
  sudo apt install -y vlc
  sudo apt install -y spacefm
  sudo apt install -y gnome-tweak-tool
  sudo apt install -y snapd

  snap install slack --classic
  snap install code --classic
  snap install bitwarden
}

setup_chrome() {
  sudo apt install -y fonts-liberation

  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  rm google-chrome-stable_current_amd64.deb
}

setup_fcitx() {
  sudo apt install -y fcitx-mozc fcitx-config-common

  echo '''
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export XMODIFIERS=@im=fcitx
  ''' >> ~/.xprofile

  # Language supportからIM Systemをfcitxにしておく
}

setup_docker() {
  sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get update
  sudo apt-get install -y docker-ce
  sudo usermod -aG docker $USER

  sudo curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

setup_base
setup_app
setup_chrome
setup_fcitx
setup_docker

LANG=C xdg-user-dirs-gtk-update
