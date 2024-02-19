# Dotfiles

Collection of my dotfiles and install scripts (archlinux, opensuse-tumbleweed).

## Description
Dotfiles cover the following programs:

* Alacritty
* Tmux
* Neovim

Install scripts for the following OSes:

* ArchLinux
* OpenSUSE Tumbleweed

## Usage

Be careful to read target-specific READMEs, they may contain important information about dependencies not covered by install scripts.

Clone the repository into `~/.dotfiles`:

```shell
git clone git@github.com:lnikon/dotfiles.git ~/.dotfiles
```

Install necessary dependencies. The `make install` target will pick up your Linux distro, and execute appropriate install scripts.

```shell
cd ~/.dotfiles
make install
```

Now, link your original dotfiles with this repo:

```shell
make all
```

If you're interested only in specific app e.g. nvim, then:

```shell
make nvim
```
