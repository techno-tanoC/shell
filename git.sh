#!/bin/sh
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
  sudo apt install -y git tig
else
  exit 1
fi

user="techno-tanoC"
email="develop.tanoc@gmail.com"

git config --global user.name "$user"
git config --global user.email "$email"
git config --global core.editor vim
git config --global merge.tool vimdiff
git config --global merge.ff false
git config --global push.default current
git config --global pull.ff only
git config --global alias.ignore '!gi() { curl -L -s https://www.gitignore.io/api/$@ ;}; gi'

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
