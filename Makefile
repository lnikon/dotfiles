alacritty:
	stow --verbose --target=$$HOME --restow alacritty

tmux:
	stow --verbose --target=$$HOME --restow tmux

nvim:
	stow --verbose --target=$$HOME --restow nvim

all:
	stow --verbose --target=$$HOME --restow alacritty
	stow --verbose --target=$$HOME --restow tmux
	stow --verbose --target=$$HOME --restow nvim

delete:
	stow --verbose --target=$$HOME --delete */

install:
