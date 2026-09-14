#!/bin/bash

# run_onchange_: chezmoi re-runs this whenever the file's contents change.
# Because the plugin list below lives IN this script, adding a plugin changes
# the script's hash, so `chezmoi apply` installs it on every machine — even
# ones that already ran this script. Each step is individually idempotent, so
# re-running is cheap and safe.

set -eu

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

# 2. Install custom plugins if missing.
#    Add new plugins here as "<name> <repo-url>"; keep in sync with the
#    plugins=( ... ) list in dot_zshrc.shared.
PLUGINS="
zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions.git
zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
fzf-tab https://github.com/Aloxaf/fzf-tab.git
"

echo "$PLUGINS" | while read -r name url; do
  [ -n "$name" ] || continue
  dest="$ZSH_CUSTOM/plugins/$name"
  if [ ! -d "$dest" ]; then
    echo "Installing plugin $name..."
    git clone --depth=1 "$url" "$dest"
  fi
done
