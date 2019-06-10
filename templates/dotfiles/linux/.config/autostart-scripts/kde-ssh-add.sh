#!/bin/bash

eval "$(ssh-agent)"
SSH_ASKPASS="$(command -v ksshaskpass)"
export SSH_ASKPASS
ssh-add < /dev/null
