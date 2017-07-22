#!/bin/bash
set -eux -o pipefail

# Install the latest version of OpenVPN.
wget -O - https://swupdate.openvpn.net/repos/repo-public.gpg|apt-key add -
echo "deb http://build.openvpn.net/debian/openvpn/stable xenial main" > /etc/apt/sources.list.d/openvpn-aptrepo.list

apt-get update
apt-get install openvpn
