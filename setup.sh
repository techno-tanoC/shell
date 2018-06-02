#!/bin/sh

base () {
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

app () {
  echo "install applications"

  sudo pacman -S --refresh --noconfirm virtualbox linux414-virtualbox-host-modules
  sudo pacman -S --noconfirm transmission-gtk spacefm gnome-control-center eog
  sudo pacman -S --noconfirm vlc qt4
  yaourt -S --noconfirm google-chrome
  yaourt -S --noconfirm patch slack-desktop
}

docker () {
  echo "install docker"

  sudo pacman -S --noconfirm docker docker-compose
  sudo usermod -aG docker $USER

  sudo systemctl enable docker.service
  sudo systemctl start docker.service
}

base
app
docker

LANG=C xdg-user-dirs-gtk-update
