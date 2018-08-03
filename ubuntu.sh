#!/bin/sh

setup_base() {
  echo "install base packages"

  sudo apt update
  sudo apt upgrade

  sudo apt install -y tree vim zsh curl
}

setup_app() {
  echo "install applications"

  sudo apt install -y slack transmission virtualbox vlc spacefm gnome-tweak-tool chrome-gnome-shell
}

setup_fcitx () {
  echo "install fcitx"

  sudo apt install -y fcitx-mozc fcitx-config-common

  echo '''
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export XMODIFIERS=@im=fcitx
  ''' >> ~/.xprofile
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
setup_app
setup_fcitx
setup_git
setup_docker

LANG=C xdg-user-dirs-gtk-update

echo "register ssh:key"
echo "\e[32m$(cat "$HOME/.ssh/id_rsa.pub")\e[m"
echo
echo "\e[32mPlease log out. You may be necessary to reboot\e[m"
