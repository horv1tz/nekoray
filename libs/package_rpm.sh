#!/bin/bash
VERSION=$1

# Подготовка структуры RPM
mkdir -p rpmbuild/{SOURCES,SPECS}
cp -r linux64/* rpmbuild/SOURCES/

# Создание spec-файла
cat > rpmbuild/SPECS/nekoray.spec << EOF
Name:           nekoray
Version:        ${VERSION}
Release:        1%{?dist}
Summary:        Network proxy tool

License:        GPL
URL:            https://github.com/your-repo/nekoray
Source0:        nekoray.tar.gz

BuildRequires:  qt6-qtbase-devel
Requires:       qt6-qtbase

%description
Network proxy tool with multiple protocols support

%prep
%setup -q

%install
mkdir -p %{buildroot}/opt/nekoray
cp -r * %{buildroot}/opt/nekoray/

%files
/opt/nekoray/*

%changelog
* $(date +"%a %b %d %Y") Your Name <your@email.com> - ${VERSION}-1
- Initial package
EOF

# Сборка RPM
rpmbuild -bb rpmbuild/SPECS/nekoray.spec
cp ~/rpmbuild/RPMS/x86_64/nekoray-${VERSION}-1.*.rpm ./nekoray.rpm