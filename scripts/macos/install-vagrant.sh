#!/bin/bash

set -ux -o pipefail
set +e

# Determine if an installation or upgrade is required.
which vagrant
if [[ "$?" == "0" ]]; then
    # Vagrant is installed. Check for the need to upgrade.
    VERSIONS=$(vagrant version)
    LATEST_VERSION=$(echo "$VERSIONS" | grep Latest | cut -d" " -f 3)
    INSTALLED_VERSION=$(echo "$VERSIONS" | grep Installed | cut -d" " -f 3)

    if [[ "$LATEST_VERSION" == "$INSTALLED_VERSION" ]]; then
        echo "Vagrant is fully updated."
        exit 0
    fi
fi

set -e

# Set up variables.
set +u
if [[ -z "$LATEST_VERSION" ]]; then
    LATEST_VERSION=$(curl -s "https://www.vagrantup.com/downloads.html" | grep dmg | sed "s/.*vagrant_//;s/_x86_64.dmg.*//")
fi
set -u

readonly TMP_DIR=/tmp/vagrant-install
readonly IMAGE="vagrant_${LATEST_VERSION}_x86_64"
readonly FILENAME="${IMAGE}.dmg"
readonly DL_URL="https://releases.hashicorp.com/vagrant/${LATEST_VERSION}/${FILENAME}"

# At this point, Vagrant is either not installed or an older version is installed.

# Download vagrant.
mkdir -p $TMP_DIR
pushd $TMP_DIR
curl $DL_URL > $FILENAME

# Mount the DMG file.
sudo hdiutil attach $FILENAME

# Install Vagrant.
sudo installer -package /Volumes/Vagrant/Vagrant.pkg -target /

# Clean up the install files.
sudo hdiutil detach /Volumes/Vagrant
popd
rm -rf $TMP_DIR

# Install vagrant plugins.
vagrant plugin install vagrant-share
vagrant plugin install vagrant-s3auth
vagrant plugin install vagrant-vbguest
