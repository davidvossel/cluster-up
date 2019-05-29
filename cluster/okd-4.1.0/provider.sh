#!/usr/bin/env bash

set -e

image="okd-4.1@sha256:9e53873338f5f0ca97273e64c16717e53c3b36fc1f971c4dfade9df4f895cea2"

source ${KUBEVIRT_PATH}/cluster/ephemeral-provider-common.sh

function _port() {
    ${_cli} ports --prefix $provider_prefix --container-name cluster "$@"
}

function up() {
    params="--random-ports --background --prefix $provider_prefix --master-cpu 5 --workers-cpu 5 --registry-volume $(_registry_volume) kubevirtci/${image}"
    if [[ ! -z "${RHEL_NFS_DIR}" ]]; then
        params=" --nfs-data $RHEL_NFS_DIR ${params}"
    fi

    ${_cli} run okd ${params}

    # Copy k8s config and kubectl
    cluster_container_id=$(docker ps -f "name=$provider_prefix-cluster" --format "{{.ID}}")
    docker cp $cluster_container_id:/bin/oc ${KUBEVIRT_PATH}cluster/$KUBEVIRT_PROVIDER/.kubectl
    chmod u+x ${KUBEVIRT_PATH}cluster/$KUBEVIRT_PROVIDER/.kubectl
    docker cp $cluster_container_id:/root/install/auth/kubeconfig ${KUBEVIRT_PATH}cluster/$KUBEVIRT_PROVIDER/.kubeconfig

    # Set server and disable tls check
    export KUBECONFIG=${KUBEVIRT_PATH}cluster/$KUBEVIRT_PROVIDER/.kubeconfig
    ${KUBEVIRT_PATH}cluster/$KUBEVIRT_PROVIDER/.kubectl config set-cluster test-1 --server=https://$(_main_ip):$(_port k8s)
    ${KUBEVIRT_PATH}cluster/$KUBEVIRT_PROVIDER/.kubectl config set-cluster test-1 --insecure-skip-tls-verify=true

    # Make sure that local config is correct
    prepare_config
}
