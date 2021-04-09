#!/usr/bin/env bash

. ./hack/bin/variables.sh

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
