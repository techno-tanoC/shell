#!/bin/sh

# cargo-update requires cmake
# cargo-web requires pkg-config

cargo install cargo-watch just cargo-update cargo-outdated cargo-tree watchexec

