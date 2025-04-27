#!/bin/bash

# zsh
ln -sf ${PWD}/home/.zshenv ~/.zshenv
ln -sf ${PWD}/home/.zprofile ~/.zprofile
ln -sf ${PWD}/home/.zshrc ~/.zshrc
# Programming language
ln -nsf ${PWD}/home/lan ~/.lan
# Create a new folder for completions
mkdir -p ~/.zsh/completions

# vim
ln -nsf ${PWD}/.vim/dein.vim ~/.vim/dein.vim
ln -nsf ${PWD}/.vim/rc ~/.vim/rc
ln -sf ${PWD}/home/.vimrc.dein ~/.vimrc.dein
ln -sf ${PWD}/home/.vimrc ~/.vimrc

# git
ln -sf ${PWD}/home/.gitignore_global ~/.gitignore_global
ln -sf ${PWD}/home/.gitconfig ~/.gitconfig
