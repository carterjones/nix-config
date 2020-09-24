#!/bin/bash
set -eux -o pipefail

[ -f /sbin/init ] || exit 0
systemctl is-active --quiet docker || exit 0

systemctl start docker
