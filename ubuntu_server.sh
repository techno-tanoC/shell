#!/bin/sh

setup_base () {
  echo "install base packages"

  sudo apt update
  sudo apt upgrade -y

  sudo apt install -y vim tree
}

setup_zsh () {
  echo "install zsh"

  sudo apt install -y zsh
  sudo chsh -s /usr/bin/zsh
}

setup_git () {
  echo "install and config git"

  name="techno-tanoC"
  email="develop.tanoc@gmail.com"

  sudo apt install -y git tig

  git config --global user.name "$name"
  git config --global user.email "$email"
  git config --global core.editor vim
  git config --global merge.tool vimdiff
  git config --global push.default current
  git config --global alias.ignore '!gi() { curl -L -s https://www.gitignore.io/api/$@ ;}; gi'

  mkdir ~/.ssh
  ssh-keygen -t rsa -C "$email" -N "" -f "$HOME/.ssh/id_rsa"
}

setup_docker () {
  echo "install docker"

  curl -fsSL get.docker.com | sh -s
  sudo usermod -aG docker $USER

  sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

setup_base
setup_zsh
setup_git
setup_docker

echo "register ssh:key"
echo "\e[32m$(cat "$HOME/.ssh/id_rsa.pub")\e[m"
echo
echo "\e[32mPlease log out. You may be necessary to reboot\e[m"
