#!/bin/bash

sudo pacman -Sy ghc cabal-install 
yay -Sy ghcup-hs-bin

cabal update

