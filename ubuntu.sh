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
  sudo apt install -y gnome-shell-extension-manager
  sudo apt install -y transmission
  sudo apt install -y vlc
  sudo apt install -y virtualbox
  sudo apt install -y spacefm
  sudo apt install -y gnome-tweaks
  sudo apt install -y xsel
  sudo apt install -y dconf-editor
  sudo apt install -y cifs-utils
}

setup_docker() {
  sudo apt install -y ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  sudo adduser $USER docker
}

setup_base
setup_app
setup_docker

LANG=C xdg-user-dirs-gtk-update
