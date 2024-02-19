.PHONY: all tmux nvim delete install

all: tmux nvim

tmux:
	stow --verbose --target=$$HOME --restow tmux

nvim:
	stow --verbose --target=$$HOME --restow nvim

delete:
	stow --verbose --target=$$HOME --delete */

install:
	./scripts/install.sh
