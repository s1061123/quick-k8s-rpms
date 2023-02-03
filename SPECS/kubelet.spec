Name: kubelet
Version: 1.27.0.dev
Release: 0
Summary: Container cluster management

License: ASL 2.0
URL: https://kubernetes.io
Source0: kubelet
Source1: kubelet.env
Source2: kubelet.service

BuildRequires: systemd
BuildRequires: curl
Requires: iptables >= 1.4.21
Requires: kubernetes-cni >= 0.8.6
Requires: socat
Requires: util-linux
Requires: ethtool
Requires: iproute
Requires: ebtables
Requires: conntrack

%description
The node agent of Kubernetes, the container cluster manager.

%prep
cp -p %SOURCE0 %{_builddir}/
cp -p %SOURCE1 %{_builddir}/
cp -p %SOURCE2 %{_builddir}/

%install
cd %{_builddir}
mkdir -p %{buildroot}%{_unitdir}/kubelet.service.d/
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}/var/lib/kubelet/
mkdir -p %{buildroot}%{_sysconfdir}/sysconfig/

install -m 755 -d %{buildroot}%{_unitdir}
install -m 755 -d %{buildroot}%{_unitdir}/kubelet.service.d/
install -m 755 -d %{buildroot}%{_bindir}
install -m 755 -d %{buildroot}/var/lib/kubelet/
install -p -m 755 -t %{buildroot}%{_bindir}/ kubelet
install -p -m 644 -t %{buildroot}%{_unitdir}/ kubelet.service
install -m 755 -d %{buildroot}%{_sysconfdir}/sysconfig/
install -p -m 644 -T kubelet.env %{buildroot}%{_sysconfdir}/sysconfig/kubelet

%files
%{_bindir}/kubelet
%{_unitdir}/kubelet.service

%config(noreplace) %{_sysconfdir}/sysconfig/kubelet

# TODO: Do we need these?
#%license add-license-file-here
#%doc add-docs-here


%changelog
* Mon Jun 22 2020 Stephen Augustus <saugustus@vmware.com> - 1.18.4
- Unbundle CNI plugins (v0.8.6) from kubelet package and release as kubernetes-cni

* Fri May 22 2020 Stephen Augustus <saugustus@vmware.com> - 1.18.4
- Bundle CNI plugins (v0.8.6) in kubelet package

* Sat Jan  4 2020 Stephen Augustus <saugustus@vmware.com> - 1.18.0
- Move kubeadm into separate spec file
- Move kubectl into separate spec file
- Move kubernetes-cni into separate spec file
- Move cri-tools into separate spec file
