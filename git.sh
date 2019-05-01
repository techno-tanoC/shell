#!/bin/bash
set -eu

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

user="techno-tanoC"
email="develop.tanoc@gmail.com"

mkdir -p ~/.ssh
ssh-keygen -t rsa -C "$email" -N "" -f "$HOME/.ssh/id_rsa"

pub=`cat $HOME/.ssh/id_rsa.pub`
host=`hostname`
json="""
{
  \"title\": \"$host\",
  \"key\": \"$pub\"
}
"""
read -sp "Enter github password: " pass

curl -u "$user:$pass" -X POST -d "$json" https://api.github.com/user/keys

git clone git@github.com:techno-tanoC/shell.git
