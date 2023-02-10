#!/bin/sh

TOP=$(dirname $(readlink -f $0))
. ${TOP}/common.sh

# copy & push required container image
# You may need to update rersion

# CoreDNSVersion in ./cmd/kubeadm/app/constants/constants.go
coredns_ver="v1.10.0"
# DefaultEtcdVersion in ./cmd/kubeadm/app/constants/constants.go
etcd_ver="3.5.7-0"
# PauseVersion in ./cmd/kubeadm/app/constants/constants.go
pause_ver="3.9"

docker pull registry.k8s.io/coredns/coredns:${coredns_ver}
docker tag registry.k8s.io/coredns/coredns:${coredns_ver} ${REPO}/coredns:${coredns_ver}
docker push ${REPO}/coredns:${coredns_ver}

docker pull registry.k8s.io/etcd:${etcd_ver}
docker tag registry.k8s.io/etcd:${etcd_ver} ${REPO}/etcd:${etcd_ver}
docker push ${REPO}/etcd:${etcd_ver}

docker pull registry.k8s.io/pause:${pause_ver}
docker tag registry.k8s.io/pause:${pause_ver} ${REPO}/pause:${pause_ver}
docker push ${REPO}/pause:${pause_ver}
