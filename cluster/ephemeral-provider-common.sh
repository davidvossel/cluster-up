#!/usr/bin/env bash

set -e

_cli_container="kubevirtci/gocli@sha256:b52e44d4e44e4c03811a42af9136492fd22f725523c4a3b9258ca9556447736d"
_cli_with_tty="docker run --privileged --net=host --rm -t -v /var/run/docker.sock:/var/run/docker.sock ${_cli_container}"
_cli="docker run --privileged --net=host --rm ${USE_TTY} -v /var/run/docker.sock:/var/run/docker.sock ${_cli_container}"

function _main_ip() {
    echo 127.0.0.1
}

function _port() {
    ${_cli} ports --prefix $provider_prefix "$@"
}

function prepare_config() {
    BASE_PATH=${KUBEVIRT_PATH:-$PWD}
    cat >cluster-hack/config-provider-$KUBEVIRT_PROVIDER.sh <<EOF
master_ip=$(_main_ip)
kubeconfig=${BASE_PATH}/cluster/$KUBEVIRT_PROVIDER/.kubeconfig
kubectl=${BASE_PATH}/cluster/$KUBEVIRT_PROVIDER/.kubectl
docker_prefix=localhost:$(_port registry)/kubevirt
manifest_docker_prefix=registry:5000/kubevirt
EOF
}

function _registry_volume() {
    echo ${job_prefix}_registry
}

function _add_common_params() {
    local params="--nodes ${KUBEVIRT_NUM_NODES} --memory ${KUBEVIRT_MEMORY_SIZE} --cpu 5 --random-ports --background --prefix $provider_prefix --registry-volume $(_registry_volume) kubevirtci/${image} ${KUBEVIRT_PROVIDER_EXTRA_ARGS}"
    if [[ $TARGET =~ windows.* ]]; then
        params=" --nfs-data $WINDOWS_NFS_DIR $params"
    elif [[ $TARGET =~ os-.* ]]; then
        params=" --nfs-data $RHEL_NFS_DIR $params"
    fi
    echo $params
}

function _kubectl() {
    export KUBECONFIG=${KUBEVIRT_PATH}cluster/$KUBEVIRT_PROVIDER/.kubeconfig
    ${KUBEVIRT_PATH}cluster/$KUBEVIRT_PROVIDER/.kubectl "$@"
}

function down() {
    ${_cli} rm --prefix $provider_prefix
}
