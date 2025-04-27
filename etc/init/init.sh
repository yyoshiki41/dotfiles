#!/bin/bash

# スクリプトの絶対パスからDOTFILES_HOMEを設定
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
DOTFILES_HOME="$DOTFILES_DIR/home"

echo $DOTFILES_DIR
exit 0

# zsh
ln -sf "$DOTFILES_HOME/.zshenv" ~/.zshenv
ln -sf "$DOTFILES_HOME/.zprofile" ~/.zprofile
ln -sf "$DOTFILES_HOME/.zshrc" ~/.zshrc
# Programming language
ln -nsf "$DOTFILES_HOME/lan" ~/.lan
# Create a new folder for completions
mkdir -p ~/.zsh/completions

# vim
ln -sf "$DOTFILES_HOME/.vimrc" ~/.vimrc

# nvim
mkdir -p ~/.config
ln -nsf "$DOTFILES_HOME/.config/nvim" ~/.config/nvim

# git
ln -sf "$DOTFILES_HOME/.gitignore_global" ~/.gitignore_global
ln -sf "$DOTFILES_HOME/.gitconfig" ~/.gitconfig
