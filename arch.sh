#!/bin/sh

setup_base () {
  echo "install base packages"

  echo '''
  [archlinuxfr]
  SigLevel = Never
  Server = http://repo.archlinux.fr/$arch
  ''' | sudo tee -a /etc/pacman.conf

  sudo pacman-mirrors -c Japan
  sudo pacman -Syyu

  sudo pacman -S --noconfirm yaourt tree vim base-devel
}

setup_app () {
  echo "install applications"

  sudo pacman -S --refresh --noconfirm virtualbox linux414-virtualbox-host-modules
  sudo pacman -S --noconfirm transmission-gtk spacefm gnome-control-center eog
  sudo pacman -S --noconfirm vlc qt4
  yaourt -S --noconfirm gnome-session-properties
  yaourt -S --noconfirm google-chrome
  yaourt -S --noconfirm patch slack-desktop
}

setup_fcitx () {
  echo "install fcitx"

  sudo pacman -S --refresh --noconfirm fcitx-im fcitx-configtool fcitx-mozc

  echo '''
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export XMODIFIERS=@im=fcitx
  ''' >> ~/.xprofile
}

setup_docker () {
  echo "install docker"

  sudo pacman -S --refresh --noconfirm docker docker-compose
  sudo usermod -aG docker $USER

  sudo systemctl enable docker.service
  sudo systemctl start docker.service
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

setup_hugo () {
  echo "install hugo"
  sudo pacman -S --noconfirm hugo
}

setup_peco () {
  echo "install peco"

  # It depends on git.
  yaourt -S --noconfirm peco
}

# Langages

setup_asdf () {
  echo "install asdf and plugins"

  sudo pacman -S --refresh --noconfirm gcc make ncurses openssh autoconf

  git clone https://github.com/asdf-vm/asdf.git ~/.asdf

  . $HOME/.asdf/asdf.sh

  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
  asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
  asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
}

setup_ruby () {
  echo "install rbenv"

  sudo pacman -S --refresh --noconfirm gcc make openssl readline sqlite

  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  mkdir ~/.rbenv/plugins
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
}

setup_rust () {
  echo "install rustup"
  curl https://sh.rustup.rs -sSf | sh -s -- -y
}

setup_base
setup_app
setup_fcitx
setup_docker
setup_git

# Langages
setup_asdf
setup_ruby
setup_rust

LANG=C xdg-user-dirs-gtk-update

echo "register ssh key:"
echo -e "\e[32m$(cat "$HOME/.ssh/id_rsa.pub")\e[m"
echo
echo -e "\e[32mPlease log out. You may be necessary to reboot\e[m"
