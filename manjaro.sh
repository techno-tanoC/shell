#!/bin/sh
set -eu

setup_base() {
  sudo pacman-mirrors -c Japan
  sudo pacman -Syyu
  sudo pacman -S --noconfirm yay

  # binutils installs the strip command
  yay -S --noconfirm base-devel
  yay -S --noconfirm tree
  yay -S --noconfirm vim
  yay -S --noconfirm zsh
  yay -S --noconfirm fd
  yay -S --noconfirm ripgrep
  yay -S --noconfirm dnsutils
  yay -S --noconfirm peco
  yay -S --noconfirm ngrok
  yay -S --noconfirm direnv
}

setup_app() {
  # VM の背景が透明になる場合は Kvantum が原因かも
  yay -S --noconfirm virtualbox linux515-virtualbox-host-modules linux515-virtualbox-guest-modules
  yay -S --noconfirm transmission-gtk
  yay -S --noconfirm spacefm
  yay -S --noconfirm eog
  yay -S --noconfirm vlc
  yay -S --noconfirm gnome-control-center
  yay -S --noconfirm gnome-tweaks
  yay -S --noconfirm extension-manager
  yay -S --noconfirm xsel
  yay -S --noconfirm bitwarden
  yay -S --noconfirm authy
  yay -S --noconfirm visual-studio-code-bin
  yay -S --noconfirm insomnia-bin
  yay -S --noconfirm slack-desktop
  yay -S --noconfirm discord
  yay -S --noconfirm android-studio

  # install font
  # yay -S --noconfirm otf-ipaexfont
  # yay -S --noconfirm noto-fonts-emoji
  # fc-cache -vf
}

setup_fcitx() {
  yay -S --refresh --noconfirm fcitx5-im fcitx5-mozc

  echo '''
  GTK_IM_MODULE=fcitx
  QT_IM_MODULE=fcitx
  XMODIFIERS=@im=fcitx

  # to autostart
  # fcitx-autostart &

  # to remap capslock to ctrl
  # setxkbmap -option ctrl:nocaps
  ''' | sudo tee -a /etc/environment
}

setup_docker() {
  yay -S --noconfirm docker docker-compose docker-machine
  sudo usermod -aG docker $USER
  sudo systemctl enable docker.service
  sudo systemctl start docker.service
}

setup_base
setup_app
setup_fcitx
setup_docker

LANG=C xdg-user-dirs-gtk-update
