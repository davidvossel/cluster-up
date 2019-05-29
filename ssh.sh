#!/usr/bin/env bash
set -e

KUBEVIRT_PATH=${KUBEVIRT_PATH:-$(dirname "$0")/}

source ${KUBEVIRT_PATH}/hack/common.sh

test -t 1 && USE_TTY="-it"
source ${KUBEVIRT_PATH}/cluster/$KUBEVIRT_PROVIDER/provider.sh
source ${KUBEVIRT_PATH}/hack/config.sh

ssh_key=${KUBEVIRT_PATH}/hack/common.key
node=$1

if [ -z "$node" ]; then
    echo "node name required as argument"
    echo "okd example: ./ssh master"
    echo "k8s example: ./ssh node01"
    exit 1
fi

if [[ $provider_prefix =~ okd.* ]]; then
    ports=$($KUBEVIRT_PATH/cli.sh --prefix $provider_prefix ports --container-name cluster)

    if [[ $node =~ worker.* ]]; then
        port=$(echo "$ports" | grep 2202 | awk -F':' '{print $2}')
    elif [[ $node =~ master.* ]]; then
        port=$(echo "$ports" | grep 2201 | awk -F':' '{print $2}')
    fi

    if [ -z "$port" ]; then
        echo "no ssh port found for $node"
        exit 1
    fi
    ssh -lcore -p $port core@127.0.0.1 -i ${ssh_key}
else
    ${_cli} --prefix $provider_prefix ssh "$1"
fi
