#!/bin/sh

TOP=$(dirname $(readlink -f $0))
. ${TOP}/common.sh

pushd ${TOP}/SPECS
rpmbuild -bb kubeadm.spec --define "_topdir ${TOP}"
rpmbuild -bb kubectl.spec --define "_topdir ${TOP}"
rpmbuild -bb kubelet.spec --define "_topdir ${TOP}"
popd

