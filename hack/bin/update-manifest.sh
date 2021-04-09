#!/usr/bin/env bash

GIT_ROOT_DIR="$(git rev-parse --show-toplevel)"
BUILD_DIR="${GIT_ROOT_DIR}/build"
MANIFEST_OUTPUT="${BUILD_DIR}/manifests/ipfailover.yaml"
MANIFEST_TEMPLATE="${GIT_ROOT_DIR}/hack/templates/manifests/ipfailover.yaml"

# TODO(sprietl):
#   Move building the manifest to skaffold buildstep if possible, to let skaffold update the deployment
NODE_COUNT=0
for ip in $(kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}'); do
  # TODO(sprietl): generate ips based on docker network used?
  NODE_IPS="${ip}0,${NODE_IPS}"
  ((NODE_COUNT++))
done

export NODE_COUNT
export NODE_IPS

# create manifest from template
mkdir -p "$(dirname "${MANIFEST_OUTPUT}")"
envsubst < "${MANIFEST_TEMPLATE}" > "${MANIFEST_OUTPUT}"
