#!/usr/bin/env bash
#
# This file is part of the KubeVirt project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Copyright 2019 Red Hat, Inc.
#

set -e

KUBEVIRT_PATH="$(
    cd "$(dirname "$BASH_SOURCE[0]")/../"
    echo "$(pwd)/"
)"

source ${KUBEVIRT_PATH}/cluster-hack/common.sh

test -t 1 && USE_TTY="-it"
source ${KUBEVIRT_PATH}/cluster/$KUBEVIRT_PROVIDER/provider.sh
source ${KUBEVIRT_PATH}/cluster-hack/config.sh

${_cli} --prefix $provider_prefix "$@"