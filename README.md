#dotfiles for fast arch/manjaro unrolling

## installation

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

Package management - [Vundle.vim](https://github.com/VundleVim/Vundle.vim)

Git wrapping - [vim-fugitive](https://github.com/tpope/vim-fugitive)

### Zsh

A huuuuuge and nice set of everyting you'll ever need [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)

### Tmux

Nothing special yet... Juse mouse is set on and splits are opening in the same path :)

Take a rest.

