#!/bin/sh

TOP=$(dirname $(readlink -f $0))
. ${TOP}/common.sh

pushd ${TOP}/SPECS
rpmbuild -bb kubeadm.spec
rpmbuild -bb kubectl.spec
rpmbuild -bb kubelet.spec
popd

