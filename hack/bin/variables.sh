#!/usr/bin/env bash

GIT_ROOT_DIR="$(git rev-parse --show-toplevel)"
BUILD_DIR="${GIT_ROOT_DIR}/build"

UPDATE_MANIFEST="${GIT_ROOT_DIR}/hack/bin/update-manifest.sh"
CLUSTER_NAME="ipfailover-test"

MANIFEST_OUTPUT="${BUILD_DIR}/manifests/ipfailover.yaml"
MANIFEST_TEMPLATE="${GIT_ROOT_DIR}/hack/templates/manifests/ipfailover.yaml"

export UPDATE_MANIFEST
export CLUSTER_NAME
export MANIFEST_OUTPUT
export MANIFEST_TEMPLATE
