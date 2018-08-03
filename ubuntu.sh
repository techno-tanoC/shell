#!/bin/bash

setup_base() {
  echo "install base packages"

  sudo apt update
  sudo apt upgrade

  sudo apt install -y tree vim zsh curl
  chsh -s $(which zsh)
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

setup_asdf() {
  echo "install asdf and plugins"

  sudo apt install -y autoconf make gcc libssl-dev libncurses5-dev

  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  . "$HOME/.asdf/asdf.sh"

  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
  asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
  asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
}

setup_ruby () {
  echo "install rbenv"

  sudo apt install -y libreadline-dev libssl-dev zlib1g-dev libsqlite3-dev
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  mkdir ~/.rbenv/plugins
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
}

setup_base
setup_app
setup_fcitx
setup_git
setup_docker
setup_asdf
setup_ruby

LANG=C xdg-user-dirs-gtk-update

echo "register ssh:key"
echo "\e[32m$(cat "$HOME/.ssh/id_rsa.pub")\e[m"
echo
echo "\e[32mPlease log out. You may be necessary to reboot\e[m"
