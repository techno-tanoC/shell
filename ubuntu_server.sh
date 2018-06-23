#!/bin/sh

setup_base () {
  echo "install base packages"

  sudo apt update
  sudo apt upgrade -y

  sudo apt install -y vim tree
}

setup_git () {
  echo "install and config git"

  name="techno-tanoC"
  email="develop.tanoc@gmail.com"

  sudo pacman -S --refresh --noconfirm git tig

  git config --global user.name "$name"
  git config --global user.email "$email"
  git config --global core.editor vim
  git config --global merge.tool vimdiff
  git config --global push.default current
  git config --global alias.ignore '!gi() { curl -L -s https://www.gitignore.io/api/$@ ;}; gi'

  mkdir ~/.ssh
  ssh-keygen -t rsa -C "$email" -N "" -f "$HOME/.ssh/id_rsa"
}

setup_base
setup_git

echo "register ssh:key"
echo -e "\e[32m$(cat "$HOME/.ssh/id_rsa.pub")\e[m"
echo
echo -e "\e[32mPlease log out. You may be necessary to reboot\e[m"
