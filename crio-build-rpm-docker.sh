#!/bin/sh

TOP=$(dirname $(readlink -f $0))
. ${TOP}/common.sh

pushd ${TOP}
if [ ! -d RPMS/x86_64 ]; then
	mkdir RPMS/x86_64
	chmod 777 RPMS/x86_64
fi

docker run --rm -v .:/usr/src -v ${CRIO_PATH}:/${CRIO_PATH} criobuild:latest /usr/src/crio-build-rpm.sh
