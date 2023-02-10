#!/bin/sh

TOP=$(dirname $(readlink -f $0))
. ${TOP}/common.sh

pushd ${TOP}/SOURCES/kubernetes

make WHAT="cmd/kubeadm"
make WHAT="cmd/kubectl"
make WHAT="cmd/kubelet"

cp _output/bin/{kubeadm,kubectl,kubelet} ..
popd
