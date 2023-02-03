#!/bin/sh

TOP=$(dirname $(readlink -f $0))
. ${TOP}/common.sh

# copy & push required container image
docker pull registry.k8s.io/coredns/coredns:v1.9.3
docker tag registry.k8s.io/coredns/coredns:v1.9.3 $REPO/coredns:v1.9.3
docker push $REPO/coredns:v1.9.3

docker pull registry.k8s.io/etcd:3.5.6-0
docker tag registry.k8s.io/etcd:3.5.6-0 $REPO/etcd:3.5.6-0
docker push $REPO/etcd:3.5.6-0

docker pull registry.k8s.io/pause:3.9
docker tag registry.k8s.io/pause:3.9 $REPO/pause:3.9
docker push $REPO/pause:3.9
