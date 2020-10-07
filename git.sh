#!/bin/bash
set -eu

echo "Did you update your ssh key to github?"
read

if [ `uname` = "Darwin" ] ; then
  /usr/bin/ruby -e "`curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install`"
  brew install git tig
elif [ `lsb_release -is` = "ManjaroLinux" ] ; then
  sudo pacman-mirrors -c Japan
  sudo pacman -Syyu
  sudo pacman -S --noconfirm git tig
elif [ `lsb_release -is` = "Ubuntu" ] ; then
  sudo apt update
  sudo apt upgrade -y
  sudo apt install -y git tig curl
else
  exit 1
fi

git clone git@github.com:techno-tanoC/shell.git ~/shell
git clone git@github.com:techno-tanoC/dotfiles.git ~/dotfiles
git clone git@github.com:techno-tanoC/secrets.git ~/secrets
