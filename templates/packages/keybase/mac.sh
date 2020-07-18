#!/bin/bash
set -eux -o pipefail

# This is a workaround to make keybase file mounting work properly. We only
# apply the workaround in the event that keybase is installed. Details here:
# https://github.com/keybase/client/issues/17796#issuecomment-647286732
if command -v keybase; then
    if xattr -rl /Library/Filesystems/kbfuse.fs/ | grep com.apple.quarantine; then
        sudo xattr -rd com.apple.quarantine /Library/Filesystems/kbfuse.fs/
    fi
fi
