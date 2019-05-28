#!/usr/bin/env bash
set -e

KUBEVIRT_PATH=${KUBEVIRT_PATH:-$(dirname "$0")/}

source ${KUBEVIRT_PATH}/hack/common.sh

test -t 1 && USE_TTY="-it"
source ${KUBEVIRT_PATH}/cluster/$KUBEVIRT_PROVIDER/provider.sh
source ${KUBEVIRT_PATH}/hack/config.sh

${_cli} --prefix $provider_prefix "$@"
