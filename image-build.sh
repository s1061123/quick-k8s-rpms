#!/bin/sh

TOP=$(dirname $(readlink -f $0))
. ${TOP}/common.sh

pushd ${TOP}/SOURCES/kubernetes
make quick-release-images
popd
