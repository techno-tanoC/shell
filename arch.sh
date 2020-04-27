#!/bin/sh
set -eu

setup_base() {
  sudo pacman-mirrors -c Japan
  sudo pacman -Syyu

  sudo pacman -S --noconfirm yay
  sudo pacman -S --noconfirm tree
  sudo pacman -S --noconfirm vim
  # binutils installs the strip command
  sudo pacman -S --noconfirm base-devel
  sudo pacman -S --noconfirm zsh
  sudo pacman -S --noconfirm fd
  sudo pacman -S --noconfirm ripgrep
  yay -S --noconfirm peco
}

setup_app() {
  # VM の背景が透明になる場合は Kvantum が原因かも
  sudo pacman -S --noconfirm virtualbox linux56-virtualbox-host-modules
  sudo pacman -S --noconfirm transmission-gtk
  sudo pacman -S --noconfirm spacefm
  sudo pacman -S --noconfirm gnome-control-center
  yay -S --noconfirm gnome-session-properties
  sudo pacman -S --noconfirm gnome-tweaks
  sudo pacman -S --noconfirm eog
  sudo pacman -S --noconfirm vlc
  # yay -S --noconfirm google-chrome
  yay -S --noconfirm patch slack-desktop
  yay -S --noconfirm visual-studio-code-bin
  yay -S --noconfirm bitwarden-bin
  yay -S --noconfirm xsel

  # install font
  sudo pacman -S --noconfirm otf-ipaexfont
  sudo pacman -S --noconfirm noto-fonts-emoji
  fc-cache -vf

  # uninstall terrain
  sudo pacman -R mesa-demos lib32-mesa-demos
}

setup_fcitx() {
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

setup_docker() {
  sudo pacman -S --refresh --noconfirm docker docker-compose docker-machine
  sudo usermod -aG docker $USER

  sudo systemctl enable docker.service
  sudo systemctl start docker.service
}

setup_gcloud() {
  # todo: completion
  name=google-cloud-sdk
  version=257.0.0
  wget -O ${name}.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${version}-linux-x86_64.tar.gz
  mkdir -p ~/.gcloud/${version}
  tar -zxf ${name}.tar.gz -C ~/.gcloud/${version}
  ${name}/install.sh --usage-reporting false
  rm ${name}.tar.gz
  # curl https://sdk.cloud.google.com | bash -s - --disable-prompts
  # restart shell
  # gcloud init
  # gcloud auth login
  # gcloud auth application-default login
  # gcloud config set_disable_usage_reporting true
}

setup_aws() {
  yay -S --noconfirm aws-cli
}

setup_base
setup_app
setup_fcitx
setup_docker

LANG=C xdg-user-dirs-gtk-update
