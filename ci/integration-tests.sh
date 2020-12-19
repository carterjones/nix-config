#!/bin/sh
set -eux

# Run the installation the first time.
./install

# Run the installation a second time so that we can uncover any strange failures that only occur
# after a previous installation has been run. We anticipate this to take significantly less time
# than the first installation.
./install
