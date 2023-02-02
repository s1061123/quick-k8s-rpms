Name: kubeadm
Version: 1.27.0.dev
Release: 0
Summary: Command-line utility for administering a Kubernetes cluster.

License: ASL 2.0
URL: https://kubernetes.io
Source0: kubeadm
Source1: 10-kubeadm.conf

# TODO: Need to templatize dependencies
BuildRequires: systemd
BuildRequires: curl
Requires: kubelet >= 1.13.0
Requires: kubectl >= 1.13.0
Requires: kubernetes-cni >= 0.8.6
Requires: cri-tools >= 1.13.0

%description
Command-line utility for administering a Kubernetes cluster.

%prep
cp -p %SOURCE0 %{_builddir}/
cp -p %SOURCE1 %{_builddir}/

%install
cd %{_builddir}
mkdir -p %{buildroot}%{_sysconfdir}/kubernetes/manifests/
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_unitdir}/kubelet.service.d

install -m 755 -d %{buildroot}%{_sysconfdir}/kubernetes/manifests/
install -p -m 755 -t %{buildroot}%{_bindir}/ kubeadm
install -p -m 644 -t %{buildroot}%{_unitdir}/kubelet.service.d/ 10-kubeadm.conf

%files
%{_bindir}/kubeadm
%{_unitdir}/kubelet.service.d/10-kubeadm.conf

# TODO: Do we need these?
#%license add-license-file-here
#%doc add-docs-here


%changelog
* Sat Jan  4 2020 Stephen Augustus <saugustus@vmware.com> - 1.18.0
- Create separate spec file for kubeadm
