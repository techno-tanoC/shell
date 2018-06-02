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

fcitx () {
  echo "install fcitx"

  sudo pacman -S --noconfirm fcitx-im fcitx-configtool fcitx-mozc

  echo '''
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export XMODIFIERS=@im=fcitx
  ''' >> ~/.xprofile
}

docker () {
  echo "install docker"

  sudo pacman -S --noconfirm docker docker-compose
  sudo usermod -aG docker $USER

  sudo systemctl enable docker.service
  sudo systemctl start docker.service
}

git () {
  echo "install and config git"

  name="techno-tanoC"
  email="develop.tanoc@gmail.com"

  sudo pacman -S --noconfirm git tig

  git config --global user.name "$name"
  git config --global user.email "$email"
  git config --global core.editor vim
  git config --global merge.tool vimdiff
  git config --global push.default current
  git config --global alias.ignore '!gi() { curl -L -s https://www.gitignore.io/api/$@ ;}; gi'

  mkdir ~/.ssh
  ssh-keygen -t rsa -C "$email" -N "" -f "$HOME/.ssh/id_rsa"

}

rust () {
  echo "install rustup"
  curl https://sh.rustup.rs -sSf | sh -s -- -y
}

base
app
fcitx
docker
git
rust

LANG=C xdg-user-dirs-gtk-update

echo "register ssh key:"
echo -e "\e[32m$(cat "$HOME/.ssh/id_rsa.pub")\e[m"
echo
echo -e "\e[32mPlease log out. You may be necessary to reboot\e[m"
