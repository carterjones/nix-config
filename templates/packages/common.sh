#!/bin/bash

function install_pkg_for_env () {
    package="${1}"
    script="${2}"
    pushd "${package}" || exit 1
    /bin/bash "${script}.sh"
    popd || exit 1
}
