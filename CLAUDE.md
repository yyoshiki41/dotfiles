# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS development environment setup. It contains configuration files for various development tools including Zsh, Neovim, Git, and multiple programming languages.

## Commands

### Setup and Installation
- `make init` - Initialize dotfiles by creating symlinks to home directory
- `make help` - Show available make commands

**Note**: The init.sh script currently has an `exit 0` on line 9 that prevents the symlink creation. This needs to be removed for the script to work properly.

### Development
- No specific build or test commands are defined in this repository
- Configuration changes take effect immediately after symlinking or reloading the respective applications

## Architecture

### Directory Structure
- `home/` - Contains all configuration files to be symlinked to user's home directory
  - `.config/nvim/` - Neovim configuration using Lazy.nvim plugin manager
  - `lan/` - Programming language-specific configurations (Go, Python, Ruby, Node.js, Java)
  - `tex/` - LaTeX-related configurations
- `etc/init/` - Initialization scripts for setting up the environment
- `Makefile` - Entry point for setup commands

### Key Components

1. **Neovim Configuration** (`home/.config/nvim/`)
   - Modern Lua-based configuration
   - Uses Lazy.nvim for plugin management
   - Modular structure with separate files for options, keymaps, autocmds, and plugins
   - Plugin configurations in `lua/plugins/` for LSP, treesitter, Git integration, etc.

2. **Shell Configuration**
   - `.zshrc` - Main Zsh configuration with prompt, completions, and aliases
   - `.zshenv` - Environment variables
   - `.zprofile` - Profile settings
   - Language-specific utilities sourced from `~/.lan/`

3. **Git Configuration**
   - `.gitconfig` - Global Git settings with aliases and configurations
   - `.gitignore_global` - Global gitignore patterns
   - Requires user to create `~/.gitconfig_local` for user-specific settings

4. **Language Support**
   - Separate utility files for each language in `home/lan/`
   - Environment variables and path configurations for development tools

### Setup Process
1. Create `~/.gitconfig_local` with user-specific Git configuration
2. Clone this repository
3. Run `make init` to create symlinks (after fixing the init.sh script)

## Important Notes

- This repository is designed for macOS environments
- Uses Homebrew for package management
- Includes Karabiner-Elements configuration for keyboard customization
- The init script creates symlinks rather than copying files, so changes in the repository are immediately reflected