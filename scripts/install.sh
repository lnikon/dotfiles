#!/bin/bash

set -x

INSTALL_SCRIPT_DIR="${HOME}/.dotfiles/scripts/"

if grep -q manjaro /etc/os-release; then
    echo "Installing packages for ArchLinux"
    INSTALL_SCRIPT_DIR="${INSTALL_SCRIPT_DIR}/archlinux"
elif grep -q tumbleweed /etc/os-release; then
    echo "Installing packages for OpenSUSE Tumbleweed"
    INSTALL_SCRIPT_DIR="${INSTALL_SCRIPT_DIR}/tumbleweed"
fi

cd $INSTALL_SCRIPT_DIR
. ./install.sh
