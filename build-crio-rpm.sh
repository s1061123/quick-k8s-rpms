#!/bin/sh

TOP=$(dirname $(readlink -f $0))
. ${TOP}/common.sh

pushd ${CRIO_PATH}
tar cfz ${TOP}/SOURCES/cri-o-test.tar.gz --exclude=.git --transform "s|^|cri-o-test/|rSH" .
popd

pushd ${TOP}/SPECS
rpmbuild -bb --nodebuginfo cri-o.spec 
popd
