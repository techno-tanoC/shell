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

setup_rust() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  # source ~/.zshrc

  # rustup target add x86_64-unknown-linux-musl

  # cargo
  # cargo-web requires pkg-config

  # cargo install cargo-watch cargo-edit just cargo-outdated cargo-tree cargo-clean-recursive watchexec-cli
  # cargo install ripgrep fd-find
}

setup_asdf() {
  set +e
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  . $HOME/.asdf/asdf.sh
  set -e
}

setup_mise() {
  curl https://mise.run | sh

  # https://usage.jdx.dev/cli/
  mise use -g usage
}

setup_elixir() {
  # erlang and elixir
  # refer below:
  # https://github.com/asdf-vm/asdf-erlang#before-asdf-install
  if [ `uname` = "Darwin" ] ; then
    # for nodejs
    brew install coreutils gpg
    # for erlang
    brew install autoconf
  elif [ `lsb_release -is` = "ManjaroLinux" ] ; then
    sudo pacman -S --needed --noconfirm base-devel ncurses glu mesa wxgtk2 libpng libssh unixodbc
  elif [ `lsb_release -is` = "Ubuntu" ] ; then
    sudo apt-get -y install build-essential autoconf m4 libncurses5-dev libwxgtk3.0-gtk3-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk
    sudo apt install -y unzip
  else
    echo "unsupported OS"
    exit 1
  fi

  asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
  asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git

  # nodejs
  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
}

setup_plugins() {
  # elm
  # asdf plugin-add elm https://github.com/asdf-community/asdf-elm.git

  # terraform
  # asdf plugin-add terraform https://github.com/Banno/asdf-hashicorp.git

  # gcloud
  asdf plugin add gcloud https://github.com/jthegedus/asdf-gcloud

  # awscli
  asdf plugin add awscli
  asdf plugin-add aws-vault https://github.com/karancode/asdf-aws-vault.git

  # k8s
  # asdf plugin-add kubectl https://github.com/Banno/asdf-kubectl.git
  # asdf plugin-add helm https://github.com/Antiarchitect/asdf-helm.git
  # asdf plugin-add istioctl https://github.com/rafik8/asdf-istioctl.git
  # asdf plugin-add kind https://github.com/reegnz/asdf-kind.git

  # ln -s ~/.asdf/installs/kubectx/$(asdf current kubectx | awk '{print $2}')/completion/_kubectx.zsh ${ASDF_DIR}/completions
  # ln -s ~/.asdf/installs/kubectx/$(asdf current kubectx | awk '{print $2}')/completion/_kubens.zsh ${ASDF_DIR}/completions
  # asdf plugin-add kubectx https://github.com/virtualstaticvoid/asdf-kubectx.git

  # golang
  # asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
}

setup_ruby
# setup_rust
setup_asdf
# setup_elixir
setup_plugins
