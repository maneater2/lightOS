#!/bin/bash

set -ouex pipefail

IMAGE="$1"

function echo_group() {
    local WHAT
    WHAT="$(
        basename "$1" .sh |
            tr "-" " " |
            tr "_" " "
    )"
    echo "::group:: === ${WHAT^^} ==="
    "$1"
    echo "::endgroup::"
}

# Desktops
case "$IMAGE" in
"workstation"*)
    cp /ctx/packages/repos/ghostty.repo /etc/yum.repos.d/ghostty.repo
    echo_group /ctx/packages/utils.sh
    echo_group /ctx/packages/gnome-extensions.sh
    echo_group /ctx/packages/virt.sh
    echo_group /ctx/branding/branding-ublue.sh
    dnf5 install -y ghostty
    dnf remove -y ptyxis
    ;;
esac
