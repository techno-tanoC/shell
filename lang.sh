#!/bin/bash
set -eu

# ruby
# refer below:
# https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
if [ `uname` = "Darwin" ] ; then
  brew install openssl readline
elif [ `lsb_release -is` = "ManjaroLinux" ] ; then
  sudo pacman -S --noconfirm --needed base-devel libffi libyaml openssl zlib
  sudo pacman -S --noconfirm --needed sqlite
elif [ `lsb_release -is` = "Ubuntu" ] ; then
  sudo apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev
  sudo apt install -y libsqlite3-dev
else
  echo "unsupported OS"
  exit 1
fi

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

mkdir -p ~/.rbenv/plugins
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# gem install pry rails

# rustup
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# source ~/.zshrc

# cargo
# cargo-update requires cmake
# cargo-web requires pkg-config

# cargo install cargo-watch just cargo-update cargo-outdated cargo-tree watchexec

