#!/bin/sh
set -eu

mkdi ~/bin

curl -L https://github.com/itchyny/mmv/releases/download/v0.1.1/mmv_v0.1.1_linux_amd64.tar.gz | tar -zxf -
mv mmv_v0.1.1_linux_amd64/mmv ~/bin/mmv
rm -rf mmv_v0.1.1_linux_amd64
