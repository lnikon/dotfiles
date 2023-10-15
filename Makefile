all:
	stow --verbose --target=$$HOME --restow alacritty
	stow --verbose --target=$$HOME --restow tmux
	stow --verbose --target=$$HOME --restow nvim
	stow --verbose --target=$$HOME --restow cabal
	stow --verbose --target=$$HOME --restow stack 

delete:
	stow --verbose --target=$$HOME --delete */

install:
	./scripts/install.sh
