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
  sudo pacman -R --noconfirm mesa-demos lib32-mesa-demos
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
  yay -S google-cloud-sdk
}

setup_aws() {
  # https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/install-cliv2-linux.html
  mkdir -p ~/bin
  mkdir temp
  cd temp
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  ./aws/install --install-dir ~/bin/awscli --bin-dir ~/bin
  cd -
  rm -rf temp

  # https://docs.aws.amazon.com/ja_jp/eks/latest/userguide/install-aws-iam-authenticator.html
  mkdir -p ~/bin
  cd ~/bin
  curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.7/2020-07-08/bin/linux/amd64/aws-iam-authenticator
  chmod +x ./aws-iam-authenticator
  cd -
}

setup_base
setup_app
setup_fcitx
setup_docker
setup_gcloud
setup_aws

LANG=C xdg-user-dirs-gtk-update
