#!/bin/sh

user="techno-tanoC"
email="develop.tanoc@gmail.com"

git config --global user.name "$user"
git config --global user.email "$email"
git config --global core.editor vim
git config --global merge.tool vimdiff
git config --global push.default current
git config --global alias.ignore '!gi() { curl -L -s https://www.gitignore.io/api/$@ ;}; gi'

mkdir ~/.ssh
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
