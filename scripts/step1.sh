#!/bin/bash 
rm /etc/apt/sources.list
touch /etc/apt/sources.list
echo "
deb http://ftp.us.debian.org/debian/ testing main contrib non-free
deb-src http://ftp.us.debian.org/debian/ testing main contrib non-free
deb http://ftp.us.debian.org/debian/ testing-updates main contrib non-free
deb-src http://ftp.us.debian.org/debian/ testing-updates main contrib non-free
# deb http://deb.debian.org/debian-security testing/updates main contrib non-free
# deb-src http://deb.debian.org/debian-security testing/updates main contrib non-free

# This system was installed using small removable media
# (e.g. netinst, live or single CD). The matching deb cdrom
# entries were disabled at the end of the installation process.
# For information about how to configure apt package sources,
# see the sources.list(5) manual.
deb http://deb.debian.org/debian/ experimental main
" >> /etc/apt/sources.list
apt update && apt full-upgrade
