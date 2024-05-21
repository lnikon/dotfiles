.PHONY: all alacritty tmux nvim hyprlan waybar delete install

all: alacritty tmux nvim hypr waybar

alacritty:
	stow --verbose --target=$$HOME --restow alacritty

tmux:
	stow --verbose --target=$$HOME --restow tmux

nvim:
	stow --verbose --target=$$HOME --restow nvim

hypr:
	stow --verbose --target=$$HOME --restow hyprland

waybar:
	stow --verbose --target=$$HOME --restow waybar

delete:
	stow --verbose --target=$$HOME --delete */

install:
	./scripts/install.sh
