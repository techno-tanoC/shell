#!/bin/bash
set -eu

setup_ruby() {
  # ruby
  # refer below:
  # https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
  if [ `uname` = "Darwin" ] ; then
    brew install openssl@3 readline libyaml gmp
  elif [ `lsb_release -is` = "ManjaroLinux" ] ; then
    sudo pacman -S --noconfirm --needed base-devel libffi libyaml openssl zlib
    sudo pacman -S --noconfirm --needed sqlite
  elif [ `lsb_release -is` = "Ubuntu" ] ; then
    sudo apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev
    sudo apt install -y libsqlite3-dev
  else
    echo "unsupported OS"
    exit 1
  fi

  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

  mkdir -p ~/.rbenv/plugins
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

  # gem install pry rails solargraph
}

setup_mise() {
  curl https://mise.run | sh

  # `mise completion` needs `usage`
  # https://usage.jdx.dev/cli/
  mise use -g usage

  mise plugins install --yes gcloud
  mise plugins install --yes awscli

  # mise plugins install --yes aws-vault
  # mise plugins install --yes terraform

  # mise plugins install --yes kubectl
  # mise plugins install --yes kind
  # mise plugins install --yes helm
  # mise plugins install --yes kustomize
  # mise plugins install --yes kubectx
}

setup_ruby
setup_mise
