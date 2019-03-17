#!/bin/sh
set -eu

setup_asdf() {
  if [ `lsb_release -is` = "ManjaroLinux" ] ; then
    sudo pacman -S --refresh --noconfirm gcc make ncurses openssh autoconf
  elif [ `lsb_release -is` = "Ubuntu" ] ; then
    sudo apt install -y autoconf make gcc libssl-dev libncurses5-dev
  else
    exit 1
  fi

  git clone https://github.com/asdf-vm/asdf.git ~/.asdf

  set +u
  . $HOME/.asdf/asdf.sh
  set -u

  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
  asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
  asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
}

setup_ruby() {
  if [ `lsb_release -is` = "ManjaroLinux" ] ; then
    sudo pacman -S --refresh --noconfirm gcc make openssl readline sqlite
  elif [ `lsb_release -is` = "Ubuntu" ] ; then
    sudo apt install -y libreadline-dev libssl-dev zlib1g-dev libsqlite3-dev
  else
    exit 1
  fi

  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  mkdir -p ~/.rbenv/plugins
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
}

setup_rust () {
  curl https://sh.rustup.rs -sSf | sh -s -- -y
}

setup_asdf
setup_ruby
setup_rust
