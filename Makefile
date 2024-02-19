.PHONY: all alacritty tmux nvim delete install

all: alacritty tmux nvim

alacritty:
	stow --verbose --target=$$HOME --restow alacritty

tmux:
	stow --verbose --target=$$HOME --restow tmux

nvim:
	stow --verbose --target=$$HOME --restow nvim

delete:
	stow --verbose --target=$$HOME --delete */

install:
	./scripts/install.sh
