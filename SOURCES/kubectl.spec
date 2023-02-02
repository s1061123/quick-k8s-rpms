Name: kubectl
Version: 1.27.0.dev
Release: 0
Summary: Command-line utility for interacting with a Kubernetes cluster.

License: ASL 2.0
URL: https://kubernetes.io
Source0: kubectl

BuildRequires: systemd
BuildRequires: curl

%description
Command-line utility for interacting with a Kubernetes cluster.

%prep
cp -p %SOURCE0 %{_builddir}/

%install

cd %{_builddir}
mkdir -p %{buildroot}/%{_bindir}
install -p -m 755 -t %{buildroot}%{_bindir}/ kubectl

%files
%{_bindir}/kubectl

# TODO: Do we need these?
#%license add-license-file-here
#%doc add-docs-here


%changelog
* Sat Jan  4 2020 Stephen Augustus <saugustus@vmware.com> - 1.18.0
- Create separate spec file for kubectl
