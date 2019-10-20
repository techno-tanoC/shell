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

email="develop.tanoc@gmail.com"

mkdir -p ~/.ssh
ssh-keygen -t ed25519 -C "$email" -N "" -f "$HOME/.ssh/id_ed25519"

host=`hostname`
pub=`cat $HOME/.ssh/id_ed25519.pub`
json="""
{
  \"title\": \"$host\",
  \"key\": \"$pub\"
}
"""

user="techno-tanoC"
read -sp "Enter github password: " pass
echo
read -sp "Enter github one-time password: " otp
echo

curl -X POST -u "$user:$pass" -H "X-GitHub-OTP: ${otp}" -d "$json" https://api.github.com/user/keys

git clone git@github.com:techno-tanoC/shell.git
