#!/bin/sh
pushd kubernetes

make WHAT="cmd/kubeadm"
make WHAT="cmd/kubectl"
make WHAT="cmd/kubelet"

cp _output/bin/{kubeadm,kubectl,kubelet} ..
popd
