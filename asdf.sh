#!/bin/bash
set -eu

git clone https://github.com/asdf-vm/asdf.git ~/.asdf

set +u
. $HOME/.asdf/asdf.sh
set -u

asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
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
