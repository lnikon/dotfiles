#!/bin/bash

set -Eeuo pipefail

sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null


sudo dnf check-update
sudo dnf update --refresh -y


sudo dnf install -y zsh git rofi alacritty neovim curl wget npm tree-sitter-cli libtree-sitter openssh ripgrep fd-find unzip llvm clang lld lldb cmake python3-pip python3-virtualenv vlc chromium code libasan telegram-desktop rustup cargo stow fira-code-fonts mozilla-fira-fonts-common mozilla-fira-mono-fonts mozilla-fira-sans-fonts

