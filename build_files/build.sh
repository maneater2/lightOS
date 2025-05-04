#!/bin/bash

set -ouex pipefail

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

# Common
echo_group /ctx/remove-cliwrap.sh
echo_group /ctx/server-packages.sh
echo_group /ctx/distrobox.sh
echo_group /ctx/branding.sh
echo_group /ctx/signing.sh
echo_group /ctx/composefs.sh

# Desktops
case "$IMAGE" in
"workstation"*)
    cp /ctx/packages/repos/ghostty.repo /etc/yum.repos.d/ghostty.repo
    echo_group /ctx/utils.sh
    echo_group /ctx/containers.sh
    echo_group /ctx/gnome-extensions.sh
    echo_group /ctx/virt.sh
    echo_group /ctx/branding/branding-ublue.sh
    dnf5 install -y ghostty
    dnf remove -y ptyxis
    ;;
esac

# Cleanup
echo_group /ctx/cleanup.sh
