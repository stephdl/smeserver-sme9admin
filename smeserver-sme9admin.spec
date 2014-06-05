# $Id: smeserver-sme8admin.spec,v 1.3 2012/09/10 00:47:40 unnilennium Exp $
# Authority: vip-ire
# Name: Daniel Berteaud
# 

Summary: A graphical monitor, alert raising, and services supervision tool for your SME Server.
%define name smeserver-sme9admin
Name: %{name}
%define version 1.5
%define release 3
Version: %{version}
Release: %{release}%{?dist}
License: GPL
Group: Networking/Daemons
Source: %{name}-%{version}.tar.gz

BuildRoot: /var/tmp/%{name}-%{version}-%{release}-buildroot
BuildArchitectures: noarch

BuildRequires: e-smith-devtools
BuildRequires: gettext

Requires: e-smith-base
Requires: smeserver-release >= 9
Requires: rrdtool-perl
Requires: rrdtool
Requires: hddtemp
Requires: sysstat
Requires: lm_sensors

AutoReqProv: no

%changelog
* Wed Jun 04 2014 stephane de Labrusse <stephdl@de-labrusse.fr> 1.5-3
- Initial release to SME Server 9

* Sun Sep 09 2012 JP Pialasse <test@pialasse.com> 1.3-3.sme
- startup fix [SME 3022]

* Wed Aug 15 2012 JP Pialasse <test@pialasse.com> 1.3-2.sme
- 64 bits [SME 7040]

* Sun Jun 10 2012 JP Pialasse <test@pialasse.com> 1.3-1.sme
- Initial version

%description
The main part of sme9admin is a daemon which gathers informations from logs 
and other tools like systat, it then feed a mysql database and create RRD
graphs about your system state.
This daemon can also send periodics mails (with some logs), and alerts mails
based on configurable thresolds.

A panel is also available in the server-manager, with which you can access gathered
data, display the RRD graphs and configure the service.

This contrib is a bit inspired by e-smith-sysmon from Shad Lords.

%prep
%setup


%build
perl createlinks
%{__mkdir_p} root/etc/e-smith/web/panels/manager/html/sme9admin
%{__mkdir_p} root/usr/share/locale/en_US/LC_MESSAGES

xgettext --from-code UTF-8 -F --no-wrap -L perl \
        -o root/usr/share/locale/en_US/LC_MESSAGES/sme9admin.po \
        root/etc/e-smith/web/functions/sme9admin \
        root/usr/bin/sme9admind

/sbin/e-smith/generate-lexicons

%install
rm -rf $RPM_BUILD_ROOT
(cd root   ; find . -depth -print | cpio -dump $RPM_BUILD_ROOT)
rm -f %{name}-%{version}-filelist
/sbin/e-smith/genfilelist $RPM_BUILD_ROOT > %{name}-%{version}-filelist

%clean 
rm -rf $RPM_BUILD_ROOT

%pre

%preun


%post

if [ $1 -eq 1 ]
then
   
   if [ -d /var/lib/sme8admin ] && [ -d /var/lib/mysql/sme8admin/ ] 
   then
        echo "After post-upgrade and reboot, you may  safely remove sme8admin, as datas will be migrated to sme9admin."
        echo "Execute 'rpm -e smeserver-sme8admin' and maybe 'mysqladmin drop sme8admin' and 'rm -Rf /var/lib/sme8admin' to completely remove sme8admin."
   fi

fi

%postun

%files -f %{name}-%{version}-filelist
%defattr(-,root,root)
%attr(755,root,root) /etc/e-smith/sql/init/sme9admin
