#!/bin/sh

pushd kubernetes
make quick-release-images

popd
