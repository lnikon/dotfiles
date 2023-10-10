#!/bin/bash

sudo pacman -Sy nix

sudo usermod -a -G nix-users nikon

sudo systemctl enable --now nix-daemon.service

nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
