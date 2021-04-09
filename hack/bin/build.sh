#!/usr/bin/env bash

GIT_ROOT_DIR="$(git rev-parse --show-toplevel)"
UPDATE_MANIFEST="${GIT_ROOT_DIR}/hack/bin/update-manifest.sh"

docker build -t "${IMAGE}" .

${UPDATE_MANIFEST}
