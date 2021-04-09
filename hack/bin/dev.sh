#!/usr/bin/env bash

# GIT_ROOT_DIR="$(git rev-parse --show-toplevel)"
# HACK_BIN_DIR="${GIT_ROOT_DIR}/hack/bin"
CLUSTER_NAME="ipfailover-test"

# start k3d server
k3d cluster create --servers 3 "${CLUSTER_NAME}"

KUBECONFIG="$(k3d kubeconfig write "${CLUSTER_NAME}")"
export KUBECONFIG

# "${HACK_BIN_DIR}/update-manifest.sh"

# run scaffold dev
skaffold dev
