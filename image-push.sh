#!/bin/sh

TOP=$(dirname $(readlink -f $0))
. ${TOP}/common.sh

pushd ${TOP}/SOURCES/kubernetes/_output/release-images/amd64/
for i in kube-apiserver kube-controller-manager kube-proxy kube-scheduler; do
	tagName=$(tar xvf $i.tar -O manifest.json | jq .[0].RepoTags[0] -r)
	docker load -i $i.tar 
	docker tag $tagName $REPO/$i:$VER
	docker push $REPO/$i:$VER
done
