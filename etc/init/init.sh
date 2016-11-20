#!/bin/bash

# zsh
ln -sf ~/dotfiles/home/.zshenv ~/.zshenv
ln -sf ~/dotfiles/home/.zprofile ~/.zprofile
ln -sf ~/dotfiles/home/.zshrc ~/.zshrc
# Programming language
ln -nsf ~/dotfiles/home/lan ~/.lan
# Create a new folder for completions
mkdir -p ~/.zsh/completions

# vim
ln -nsf ~/dotfiles/.vim/dein.vim ~/.vim/dein.vim
ln -nsf ~/dotfiles/.vim/rc ~/.vim/rc
ln -sf ~/dotfiles/home/.vimrc.dein ~/.vimrc.dein
ln -sf ~/dotfiles/home/.vimrc ~/.vimrc

# git
ln -sf ~/dotfiles/home/.gitignore_global ~/.gitignore_global
ln -sf ~/dotfiles/home/.gitconfig ~/.gitconfig
