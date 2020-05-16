#!/bin/bash
set -eu

set +e
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
. $HOME/.asdf/asdf.sh
set -e

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
  sudo apt-get -y install build-essential autoconf m4 libncurses5-dev libwxgtk3.0-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop
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

# elm
asdf plugin-add elm https://github.com/vic/asdf-elm.git

# infra
asdf plugin-add terraform https://github.com/Banno/asdf-hashicorp.git

# k8s
asdf plugin-add kubectl https://github.com/Banno/asdf-kubectl.git
asdf plugin-add kubectx https://github.com/trnubo/asdf-kubectx.git
asdf plugin-add kubesec https://github.com/vitalis/asdf-kubesec.git
asdf plugin-add kustomize https://github.com/Banno/asdf-kustomize.git
asdf plugin-add helm https://github.com/Antiarchitect/asdf-helm.git
asdf plugin-add istioctl https://github.com/rafik8/asdf-istioctl.git
asdf plugin-add kind https://github.com/reegnz/asdf-kind.git
