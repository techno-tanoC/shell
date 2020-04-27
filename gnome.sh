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

# dash_to_dock
# https://extensions.gnome.org/extension/307/dash-to-dock/

# multi monitors add on
# https://extensions.gnome.org/extension/921/multi-monitors-add-on/

# clipboard indiccator
# https://extensions.gnome.org/extension/779/clipboard-indicator/

# shelltile
# https://extensions.gnome.org/extension/657/shelltile/
