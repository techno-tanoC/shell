#!/bin/sh

install_multi_monitors_add_on() {
  # version 17 targets upper gnome 3.24
  URL=https://extensions.gnome.org/extension-data/multi-monitors-add-on%40spin83.v17.shell-extension.zip
  FILE=multi-monitors-add-on.zip
  NAME=multi-monitors-add-on@spin83

  wget -O $FILE $URL
  unzip -q -d ~/.local/share/gnome-shell/extensions/${NAME} $FILE
  # gnome-shell-extension-tool -e $NAME
  rm $FILE
}

install_dash_to_dock() {
  # version 64 targets gnome 3.18 ~ 3.30
  URL=https://extensions.gnome.org/extension-data/dash-to-dock%40micxgx.gmail.com.v64.shell-extension.zip
  FILE=dash-to-dock.zip
  NAME=dash-to-dock@micxgx.gmail.com

  wget -O $FILE $URL
  unzip -q -d ~/.local/share/gnome-shell/extensions/${NAME} $FILE
  # gnome-shell-extension-tool -e $NAME
  rm $FILE
}

mkdir -p ~/.local/share/gnome-shell/extensions/

install_multi_monitors_add_on
# install_dash_to_dock
