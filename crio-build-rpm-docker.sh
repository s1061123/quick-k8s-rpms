#!/bin/sh

docker run -v .:/usr/src criobuild:latest /usr/src/crio-build-rpm.sh
