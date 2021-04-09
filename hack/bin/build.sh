#!/usr/bin/env bash

. ./hack/bin/variables.sh

docker build -t "${IMAGE}" .

${UPDATE_MANIFEST}
