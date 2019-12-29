#!/bin/bash

echo "Retreive fastest mirrors"
sudo pacman-mirrors --fasttrack 10
echo "...done\n"

echo "Update system"
sudo pacman -Syyu
echo "...done\n"

echo "Install minimal set of packages"
sudo pacman --noconfirm -S wget curl git vim tmux zsh cmake
echo "...done\n"
