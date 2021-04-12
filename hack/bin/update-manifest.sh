#!/usr/bin/env bash

. ./hack/bin/variables.sh

# TODO(sprietl):
#   Move building the manifest to skaffold buildstep if possible, to let skaffold update the deployment
OPENSHIFT_HA_REPLICA_COUNT=0
for ip in $(kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}'); do
  # TODO(sprietl): generate ips based on docker network used?
  OPENSHIFT_HA_VIRTUAL_IPS="${ip}0,${OPENSHIFT_HA_VIRTUAL_IPS}"
  ((OPENSHIFT_HA_REPLICA_COUNT++))
done

export OPENSHIFT_HA_REPLICA_COUNT
export OPENSHIFT_HA_VIRTUAL_IPS

# create manifest from template
# mkdir -p "$(dirname "${MANIFEST_OUTPUT}")"
# envsubst < "${MANIFEST_TEMPLATE}" > "${MANIFEST_OUTPUT}"
