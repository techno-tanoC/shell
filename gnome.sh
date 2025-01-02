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

# clipboard indiccator
# https://extensions.gnome.org/extension/779/clipboard-indicator/

# Dash to Panel
# https://extensions.gnome.org/extension/1160/dash-to-panel/
