#!/bin/bash
set -eu

setup_mise() {
  curl https://mise.run | sh

  # `mise completion` needs `usage`
  # https://usage.jdx.dev/cli/
  mise use -g usage

  mise plugins install --yes gcloud
  mise plugins install --yes awscli

  # mise plugins install --yes aws-vault
  # mise plugins install --yes terraform

  # mise plugins install --yes kubectl
  # mise plugins install --yes kind
  # mise plugins install --yes helm
  # mise plugins install --yes kustomize
  # mise plugins install --yes kubectx
}

setup_mise
