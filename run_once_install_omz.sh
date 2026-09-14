#!/bin/bash

# Guard: the Oh My Zsh installer only respects --keep-zshrc when ~/.zshrc
# already exists. If it is missing, the installer falls through and writes
# its default template (ZSH_THEME="robbyrussell", plugins=(git)), which would
# be sourced after ~/.zshrc.shared and silently override it.
# run_once_before_bootstrap_zshrc.sh normally creates ~/.zshrc first; this is
# a belt-and-braces fallback.
touch "$HOME/.zshrc"

# 1. Install Oh My Zsh unattended if missing
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# 2. Install custom plugins if missing
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/fzf-tab" ]; then
  git clone https://github.com/Aloxaf/fzf-tab.git "$ZSH_CUSTOM/plugins/fzf-tab"
fi
