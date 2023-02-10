#!/bin/sh

docker run -v .:/usr/src criobuild:latest /usr/src/build-crio-rpm.sh
