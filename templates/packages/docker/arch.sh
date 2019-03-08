#!/bin/bash
set -euxo pipefail

[ -f /sbin/init ] || exit 0
systemctl is-active --quiet docker || exit 0

systemctl start docker
