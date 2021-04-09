#!/usr/bin/env bash

. ./hack/bin/variables.sh

# start k3d server
k3d cluster create --servers 3 "${CLUSTER_NAME}"

KUBECONFIG="$(k3d kubeconfig write "${CLUSTER_NAME}")"
export KUBECONFIG

${UPDATE_MANIFEST}

# run scaffold dev
skaffold dev
