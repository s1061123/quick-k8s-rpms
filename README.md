## kubernetes quick rpm build workspace

This is pretty dirty but simple/quick Kubernetes RPM build.

### Prerequisites

1. Install packages required to build RPMs and latest golang.

```
$ sudo dnf install -y rpmdevtools dnf-utils
```

2. Clone this repo.

```
$ git clone https://github.com/s1061123/quick-k8s-rpms
```

3. Clone kubernetes under `SOURCES` directory.

```
$ cd quick-k8s-rpms/SOURCES
$ git clone https://github.com/kubernetes/kubernetes
```

4. Set quick-k8s-rpms directory to `%_topdir` in `~/.rpmmacros`.

```
$ vi ~/.rpmmacros
<edit the file>

$ cat ~/.rpmmacros
%_topdir %(echo $HOME)/src/quick-k8s-rpms
$
```

5. Create following repositories in container registry

- coredns
- etcd
- kube-api-server
- kube-controller-manager
- kube-proxy
- kube-scheduler
- pause

6. Configure `common.sh` parameters to fit your environment (container registory URL, kubernetes build version, cri-o path)

```
$ vi common.sh
<edit the file>
```

7. Execute `./default-image-push.sh` to push required container image (pause/coredns and so on).
```
$ ./default-image-push.sh
```

## Build Kubernetes

Kubernetes artifacts are two types: RPM based package and container image.

RPM:

- kubelet
- kubectl
- kubeadm

Container Image:

- kube-apiserver
- kube-controller-manager
- kube-proxy
- kube-scheduler

### RPM based install components

#### Build Kubernetes binaries

Execute `./builds.sh` to build kubelet/kubectl/kubeadm. These binaries are copied to `SOURCES` to build RPMs.

```
$ ./k8s-cmd-build.sh
```

#### Build RPMS

Execute `./rpmbuild.sh` to build RPMs. Artifacts goes into `RPMS/<arch (e.g. x86_64)>` directory.

```
$ ./k8s-rpmbuild.sh
```

### Container based install components

#### Build images

Execute `./image-build.sh` to build container images. These container images are built at SOURCES/kubernetes/_output/release-images/amd64/.

```
$ ./k8s-image-build.sh
```

#### Push images

Execute `./image-push.sh` to push images to container registry. These container images are built at SOURCES/kubernetes/_output/release-images/amd64/.

```
$ ./k8s-image-push.sh
```

## Build cri-o 

Get cri-o source from github

```
$ cd SOURCES
$ git clone https://github.com/cri-o/cri-o
```

Do build (in host OS)

```
$ ./crio-build-rpm.sh
```

Do build (in container host, if running OS and target OS is different)

```
$ pushd images
$ docker build -f Dockerfile.crio -t criobuild:latest .
$ popd
$ ./crio-build-rpm-docker.sh
```

#### Note
 
- RPM spec files from [kubepkg](https://github.com/kubernetes/release/tree/master/cmd/kubepkg) and [fedora/cri-o](https://src.fedoraproject.org/rpms/cri-o/blob/rawhide/f/cri-o.spec)
