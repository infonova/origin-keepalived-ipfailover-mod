#!/usr/bin/env bash

set -e

SCRIPT_PATH="$(realpath "${0}")"
SCRIPT_DIR="$(dirname "${SCRIPT_PATH}")"
CONTAINER_TESTS_DIR="${SCRIPT_DIR}/container"

docker run --rm -v "${CONTAINER_TESTS_DIR}":/tests --entrypoint /tests/entrypoint.sh "$IMAGE" --version

#exit 1
