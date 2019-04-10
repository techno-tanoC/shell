#!/bin/bash
set -eu

setup_asdf() {
  # refer below:
  # https://github.com/asdf-vm/asdf-erlang#before-asdf-install
  if [ `uname` = "Darwin" ] ; then
    brew install autoconf wxmac
  elif [ `lsb_release -is` = "ManjaroLinux" ] ; then
    sudo pacman -S --noconfirm base-devel ncurses glu mesa wxgtk2 libpng libssh unixodbc
    sudo pacman -S --noconfirm unzip
  elif [ `lsb_release -is` = "Ubuntu" ] ; then
    sudo apt install -y build-essential autoconf m4 libncurses5-dev libwxgtk3.0-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop
    sudo apt install -y unzip
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
  asdf plugin-add elm https://github.com/vic/asdf-elm.git
}

setup_ruby() {
  # refer below:
  # https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
  if [ `uname` = "Darwin" ] ; then
    brew install openssl libyaml libffi
  elif [ `lsb_release -is` = "ManjaroLinux" ] ; then
    sudo pacman -S --noconfirm base-devel libffi libyaml openssl zlib
    sudo pacman -S --noconfirm sqlite
  elif [ `lsb_release -is` = "Ubuntu" ] ; then
    sudo apt install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev
    sudo apt install -y libsqlite3-dev
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
