# dotfiles for fast arch/manjaro unrolling

## Installation

Copy this repo into `$HOME/.dotfiles` directory

`cd $HOME`

`mkdir .dotfiles`

`git clone --recurse-submodules --remote-submodules https://github.com/lnikon/dotfiles .dotfiles`

Change directory and make scripts executable

`cd $HOME/.dotfiles`

`chmod +x install_pkgs.sh`

`chmod +x install_dotfiles.sh`

Run `install_pkgs.sh` to update mirrors list and system, install necessary packages

`./install_pkgs.sh`

Run `install_dotfiles.sh` to unroll dotfiles

`./install_dotfiles.sh`

## What's included

### Vim Plugins

#### Package management

* [Vundle.vim](https://github.com/VundleVim/Vundle.vim)

#### Git Integration

* Git wrapping - [vim-fugitive](https://github.com/tpope/vim-fugitive)

#### C/C++

* C/C++ Autocomplete with support of Clang - [clang_complete](https://github.com/xavierd/clang_complete)
* C/C++ Syntax Enhanced [vim-cpp-enhanced-highlight](https://github.com/octol/vim-cpp-enhanced-highlight)

#### Others
* File Explorer [vim-vinegar](https://github.com/tpope/vim-vinegar)

### Shell

#### Zsh

* All-in-One plugin list for zsh [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)

#### Tmux 
Nothing special yet... Juse mouse is set on and splits are opening in the same path :)

#### etc...
Take a rest.

# ToDo
* Provide a human-worthy python script for automatic installation/linking
* [vim] Plugin for session save/load
* [vim/cpp] C/C++ Syntax Check
* [vim/cpp] C/C++ Format(clang-format)
* [vim/cpp] Cmake support ???
* [vim/cpp] C/C++ Build/Run/(debug?)
