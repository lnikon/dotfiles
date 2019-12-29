#!/bin/bash

main_dotfiles_dir=~/.dotfiles
old_dotfiles_dir=~/dotfiles_old
files="bashrc tmux.conf vimrc zshrc vim oh-my-zsh"

echo "Creating $old_dotfiles_dir for backup of any existing dotfiles in ~"
mkdir -p $old_dotfiles_dir
echo "...done"

echo "Chainging to the $main_dotfiles_dir directory"
cd $main_dotfiles_dir
echo "...done"

for file in $files; do
    echo "Moving any existing dotfiles from ~ to $old_dotfiles_dir"
    mv ~/.$file $old_dotfiles_dir
    echo "Creating symlink to $file in home directory"
    ln -s $main_dotfiles_dir/$file ~/.$file
done
