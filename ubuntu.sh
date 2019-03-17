#!/bin/bash
set -eu

setup_base() {
  echo "install base packages"

  sudo apt update
  sudo apt upgrade -y

  sudo apt install -y tree vim zsh curl
  # chsh -s $(which zsh)
}

setup_app() {
  echo "install applications"

  sudo apt install -y transmission virtualbox vlc spacefm gnome-tweak-tool
}

setup_chrome() {
  echo "install chrome"

  sudo apt install -y chrome-gnome-shell

  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  rm google-chrome-stable_current_amd64.deb
}

setup_vscode() {
  echo "install vscode"

  wget https://az764295.vo.msecnd.net/stable/1dfc5e557209371715f655691b1235b6b26a06be/code_1.25.1-1531323788_amd64.deb
  sudo dpkg -i code_1.25.1-1531323788_amd64.deb
  rm code_1.25.1-1531323788_amd64.deb
}

setup_fcitx () {
  echo "install fcitx"

  sudo apt install -y fcitx-mozc fcitx-config-common

  echo '''
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export XMODIFIERS=@im=fcitx
  ''' >> ~/.xprofile

  # Language supportからIM Systemをfcitxにしておく
}

setup_docker () {
  echo "install docker"

  curl -fsSL get.docker.com | sh -s
  sudo usermod -aG docker $USER

  sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

setup_peco() {
  echo "install peco"

  sudo apt install -y peco

  mkdir -p ~/.config/peco
  echo """
{
  "Layout": "bottom-up"
}
  """ > ~/.config/peco/config.json
}

setup_asdf() {
  echo "install asdf and plugins"

  sudo apt install -y autoconf make gcc libssl-dev libncurses5-dev

  git clone https://github.com/asdf-vm/asdf.git ~/.asdf

  set +u
  . "$HOME/.asdf/asdf.sh"
  set -u

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

setup_rust() {
  echo "install rustup"

  curl https://sh.rustup.rs -sSf | sh -s -- -y
}

setup_stack() {
  echo "install stack"

  wget -qO- https://get.haskellstack.org/ | sh
  stack setup
}

setup_base
setup_app
setup_chrome
setup_vscode
setup_fcitx
setup_docker

setup_asdf
setup_ruby
setup_rust
setup_stack

LANG=C xdg-user-dirs-gtk-update
