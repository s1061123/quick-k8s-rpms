#!/bin/sh

rpmbuild -bb kubeadm.spec
rpmbuild -bb kubectl.spec
rpmbuild -bb kubelet.spec

