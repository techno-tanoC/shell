#!/bin/sh
set -eu

setup_base() {
  sudo pacman-mirrors -c Japan
  sudo pacman -Syyu

  sudo pacman -S --noconfirm yay
  yay -S --noconfirm tree
  yay -S --noconfirm vim
  # binutils installs the strip command
  yay -S --noconfirm base-devel
  yay -S --noconfirm zsh
  yay -S --noconfirm fd
  yay -S --noconfirm peco
  yay -S --noconfirm pv
  yay -S --noconfirm ripgrep
}

setup_app() {
  # VM の背景が透明になる場合は Kvantum が原因かも
  yay -S --noconfirm virtualbox linux419-virtualbox-host-modules
  yay -S --noconfirm transmission-gtk
  yay -S --noconfirm spacefm
  yay -S --noconfirm gnome-control-center
  yay -S --noconfirm gnome-session-properties
  yay -S --noconfirm gnome-tweaks
  yay -S --noconfirm eog
  yay -S --noconfirm vlc
  yay -S --noconfirm google-chrome
  yay -S --noconfirm patch slack-desktop
  yay -S --noconfirm visual-studio-code-bin
  yay -S --noconfirm bitwarden-bin
  yay -S --noconfirm xsel

  # install font
  yay -S --noconfirm otf-ipaexfont
  yay -S --noconfirm noto-fonts-emoji
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
