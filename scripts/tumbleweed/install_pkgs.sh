#!/bin/bash

yes | sudo zypper install zsh git neovim curl wget npm nodejs21 tree-sitter \
                    openssh ripgrep fd unzip sudo
yes | sudo zypper install -t pattern base devel_basis devel_C_C++ devel_python3
