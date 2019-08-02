#!/bin/sh
set -eu

setup_base () {
  sudo pacman-mirrors -c Japan
  sudo pacman -Syyu

  sudo pacman -S --noconfirm yay
  yay -S --noconfirm tree
  yay -S --noconfirm vim
  yay -S --noconfirm base-devel
  yay -S --noconfirm zsh
  yay -S --noconfirm fd
  yay -S --noconfirm peco
  yay -S --noconfirm pv
}

setup_app () {
  yay -S --noconfirm virtualbox linux419-virtualbox-host-modules
  yay -S --noconfirm transmission-gtk
  yay -S --noconfirm spacefm
  yay -S --noconfirm gnome-control-center
  yay -S --noconfirm eog
  yay -S --noconfirm vlc qt4
  yay -S --noconfirm gnome-session-properties
  yay -S --noconfirm google-chrome
  # pacth is needed?
  yay -S --noconfirm patch slack-desktop
  yay -S --noconfirm visual-studio-code-bin
  yay -S --noconfirm bitwarden-bin

  # install font
  yay -S ttf-mplus
  fc-cache -vf
}

setup_option () {
  yay -S --noconfirm calibre
  yay -S --noconfirm android-tools
}

setup_fcitx () {
  sudo pacman -S --refresh --noconfirm fcitx-im fcitx-configtool fcitx-mozc

  echo '''
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export XMODIFIERS=@im=fcitx

  # to autostart
  # fcitx-autostart &

  # to remap capslock to ctrl
  # setxkbmap -option ctrl:nocaps
  ''' >> ~/.xprofile
}

setup_docker () {
  sudo pacman -S --refresh --noconfirm docker docker-compose
  sudo usermod -aG docker $USER

  sudo systemctl enable docker.service
  sudo systemctl start docker.service
}

setup_gcloud () {
  # todo: completion
  curl https://sdk.cloud.google.com | bash
  # restart shell
  # gcloud init
  # gcloud auth login
}

setup_kube () {
  yay -S --noconfirm kubectl-bin
  yay -S --noconfirm kubernetes-helm-bin
  yay -S --noconfirm kubectx
  yay -S --noconfirm istio-bin
}

setup_base
setup_app
setup_fcitx
setup_docker

LANG=C xdg-user-dirs-gtk-update
