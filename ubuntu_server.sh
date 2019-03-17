#!/bin/sh

setup_base () {
  sudo apt update
  sudo apt upgrade -y

  sudo apt install -y vim tree
}

setup_zsh () {
  sudo apt install -y zsh
  chsh -s /usr/bin/zsh
}

setup_docker () {
  curl -fsSL get.docker.com | sh -s
  sudo usermod -aG docker $USER

  sudo curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

setup_base
setup_zsh
setup_docker
