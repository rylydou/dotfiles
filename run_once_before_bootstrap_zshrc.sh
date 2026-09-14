#!/bin/bash
# Ensure ~/.zshrc sources the chezmoi-managed shared config.
#
# ~/.zshrc is intentionally NOT managed by chezmoi: package installers
# (bun, nvm, rustup, ...) append to it, which would constantly dirty the
# source state. Instead chezmoi manages ~/.zshrc.shared and this script
# wires it up once per machine.
#
# This MUST run before install_omz.sh. The Oh My Zsh installer only honours
# --keep-zshrc when ~/.zshrc already exists; if it is missing the installer
# writes its default template (robbyrussell, plugins=(git)) which would be
# sourced after ~/.zshrc.shared and override it.

ZSHRC="$HOME/.zshrc"
MARKER='.zshrc.shared'

if [ -f "$ZSHRC" ] && grep -qF "$MARKER" "$ZSHRC"; then
  exit 0
fi

TMP="$(mktemp)"
cat > "$TMP" <<'HEADER'
# --- Shared Config ---
# Managed by chezmoi. Machine-specific overrides go below.
if [ -f "$HOME/.zshrc.shared" ]; then
  source "$HOME/.zshrc.shared"
fi

HEADER

[ -f "$ZSHRC" ] && cat "$ZSHRC" >> "$TMP"
mv "$TMP" "$ZSHRC"
