#!/bin/bash
set -eu

if [ `uname` = "Darwin" ] ; then
  # brew cask install google-cloud-sdk
  # brew install kubectx
  # brew install kubernetes-helm
elif [ `lsb_release -is` = "ManjaroLinux" ] ; then
  curl https://sdk.cloud.google.com | bash
  exec -l $SHELL
  gcloud init
  yay -S --noconfirm kubectl-bin
  yay -S --noconfirm kubectx
  yay -S --noconfirm kubernetes-helm-bin
elif [ `lsb_release -is` = "Ubuntu" ] ; then
  curl https://sdk.cloud.google.com | bash
  exec -l $SHELL
  gcloud init
  gcloud components install kubectl
  sudo apt install -y kubectx
else
  exit 1
fi

# gcloud auth login

# istio
