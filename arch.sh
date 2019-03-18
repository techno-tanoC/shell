#!/bin/sh
set -eu

setup_base () {
  # echo '''
  # [archlinuxfr]
  # SigLevel = Never
  # Server = http://repo.archlinux.fr/$arch
  # ''' | sudo tee -a /etc/pacman.conf

  sudo pacman-mirrors -c Japan
  sudo pacman -Syyu

  sudo pacman -S --noconfirm yay tree vim base-devel zsh fd
  yay -S --noconfirm peco
}

setup_app () {
  sudo pacman -S --refresh --noconfirm virtualbox linux419-virtualbox-host-modules
  sudo pacman -S --noconfirm transmission-gtk spacefm gnome-control-center eog
  sudo pacman -S --noconfirm vlc qt4
  yay -S --noconfirm gnome-session-properties
  yay -S --noconfirm google-chrome
  yay -S --noconfirm patch slack-desktop
}

setup_fcitx () {
  sudo pacman -S --refresh --noconfirm fcitx-im fcitx-configtool fcitx-mozc

  echo '''
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export XMODIFIERS=@im=fcitx
  ''' >> ~/.xprofile
}

setup_docker () {
  sudo pacman -S --refresh --noconfirm docker docker-compose
  sudo usermod -aG docker $USER

  sudo systemctl enable docker.service
  sudo systemctl start docker.service
}

setup_base
setup_app
setup_fcitx
setup_docker

LANG=C xdg-user-dirs-gtk-update
