#!/bin/bash

yes | sudo pacman -Sy --noconfirm base-devel git vim neovim curl wget yay \
                      gcc clang unzip openssh tree-sitter \
                      nodejs npm ttf-dejavu nerd-fonts nix \
                      hyprland waybar inotify-tools

