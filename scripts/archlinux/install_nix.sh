#!/bin/bash

# Install nix to be package manager agnostic
sudo pacman -Sy nix

# Add $USER to nix-users group so it can use nix commands
sudo usermod -a -G nix-users $USER

# Update $USERs group membership
sudo su - $USER

# Enable nix system service
sudo systemctl enable --now nix-daemon.service

# Use cutting edge channels
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
