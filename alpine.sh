#!/bin/ash -eu

setup_user() {
  apk add --no-cache sudo
  echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel
  adduser -u 1000 tech
  adduser tech wheel
}

setup_base() {
  sudo apk add --no-cache vim
  sudo apk add --no-cache git
  sudo apk add --no-cache tree
  sudo apk add --no-cache wget
  sudo apk add --no-cache curl
  sudo apk add --no-cache cifs-utils
}

setup_ssh() {
  mkdir .ssh
  chmod 700 .ssh
  wget -O .ssh/authorized_keys https://github.com/techno-tanoC.keys
}

setup_docker() {
  # enabme community on /etc/apk/repositories
  sudo apk add --no-cache docker
  sudo service docker start
  sudo rc-update add docker boot
  sudo adduser $USER docker

  mkdir -p ~/.docker/cli-plugins/
  curl -SL https://github.com/docker/compose/releases/download/v2.2.2/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
  chmod +x ~/.docker/cli-plugins/docker-compose
}
