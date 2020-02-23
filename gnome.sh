#!/bin/sh
set -eu

install_add_on() {
  URL=$1
  FILE=$2
  NAME=$3

  wget -O $FILE $URL
  unzip -q -d ~/.local/share/gnome-shell/extensions/${NAME} $FILE
  # gnome-shell-extension-tool -e $NAME
  rm $FILE
}

install_multi_monitors_add_on() {
  # version 18 targets upper gnome 3.32
  URL=https://extensions.gnome.org/extension-data/multi-monitors-add-onspin83.v18.shell-extension.zip
  FILE=multi-monitors-add-on.zip
  NAME=multi-monitors-add-on@spin83

  install_add_on $URL $FILE $NAME
}

install_dash_to_dock() {
  # version 64 targets gnome 3.18 ~ 3.30
  URL=https://extensions.gnome.org/extension-data/dash-to-dock%40micxgx.gmail.com.v64.shell-extension.zip
  FILE=dash-to-dock.zip
  NAME=dash-to-dock@micxgx.gmail.com

  install_add_on $URL $FILE $NAME
}

install_shell_tile() {
  # https://extensions.gnome.org/extension/657/shelltile/
}

install_gtile() {
  # https://extensions.gnome.org/extension/28/gtile/
}

mkdir -p ~/.local/share/gnome-shell/extensions/

install_multi_monitors_add_on
# install_dash_to_dock

# multi monitors add on
# dash to dock
# clipboard indiccator
# shelltile

