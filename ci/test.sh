#!/bin/bash
set -eux -o pipefail

# Change to the root directory.
cd "$(git rev-parse --show-toplevel)"

if [[ "${OS}" == "macos" ]]; then
    # If this is a MacOS environment, run the install script directly.
    ./install
else
    # If this is not a MacOS environment, build a Docker container to run the tests.
    docker build \
        --tag "${OS}-ci" \
        --file "./ci/Dockerfile" \
        --build-arg IMAGE="carterjones/${OS}" \
        .

    # Prepare a trap so that Arch and Manjaro testing always succeeds. We don't care if they break
    # since they're bleeding edge. We expect them to break. We want to log the test results
    # nonetheless.
    if [[ "${OS}" == "arch" ]] || [[ "${OS}" == "manjaro" ]]; then
        function clean_exit {
            exit 0
        }
        trap clean_exit EXIT
    fi

    # Run the tests.
    docker run -v "$(pwd):/nix-config" "${OS}-ci" /bin/bash /nix-config/ci/bootstrap-tests.sh
fi
