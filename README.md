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

6. In `SOURCES` directory, execute `./default-image-push.sh` to push required container image (pause/coredns and so on). 
```
$ cd SOURCES
$ ./default-image-push.sh
```

### RPM based install components (kubelet/kubectl/kubeadm)

#### Build Kubernetes binaries (kubelet/kubectl/kubeadm)

In `SOURCES` directory, execute `./builds.sh` to build kubelet/kubectl/kubeadm. These binaries are copied to `SOURCES` to build RPMs.

```
$ cd SOURCES
$ ./builds.sh
```

#### Build RPMS

In `SOURCES` directory, execute `./rpmbuild.sh` to build RPMs. Artifacts goes into `RPMS/<arch (e.g. x86_64)>` directory.

```
$ cd SOURCES
$ ./rpmbuilds.sh
```
### Container based install components (kube-apiserver/kube-controller-manager/kube-proxy/kube-scheduler)

#### Build images

In `SOURCES` directory, execute `./image-build.sh` to build container images. These container images are built at SOURCES/kubernetes/_output/release-images/amd64/.

```
$ cd SOURCES
$ ./image-build.sh
```

#### Push images

In `SOURCES` directory, execute `./image-push.sh` to push images to container registry. These container images are built at SOURCES/kubernetes/_output/release-images/amd64/.

```
$ cd SOURCES
$ ./image-push.sh
```


#### Note

- RPM spec files from [kubepkg](https://github.com/kubernetes/release/tree/master/cmd/kubepkg)
