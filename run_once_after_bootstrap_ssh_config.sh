#!/bin/bash
# Ensure ~/.ssh/config includes the chezmoi-managed shared config.
#
# ~/.ssh/config is intentionally NOT managed by chezmoi: it holds
# machine-specific hosts (real hostnames, IPs, users, MAC addresses) that
# should not land in a public repo. Instead chezmoi manages
# ~/.ssh/config.shared and this script wires it up once per machine.
#
# The Include goes at the *end*, unlike the ~/.zshrc pattern: ssh_config is
# first-match-wins, so local host blocks must be parsed before the shared
# "Host *" defaults for local settings to take precedence.

set -e

SSH_DIR="$HOME/.ssh"
CONFIG="$SSH_DIR/config"
MARKER='Include ~/.ssh/config.shared'

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

if [ -f "$CONFIG" ] && grep -qF "$MARKER" "$CONFIG"; then
  exit 0
fi

{
  [ -f "$CONFIG" ] && cat "$CONFIG"
  cat <<'FOOTER'

# --- Shared Config ---
# Managed by chezmoi. Machine-specific hosts go above this line: ssh_config
# is first-match-wins, so anything after this Include loses to the defaults.
Include ~/.ssh/config.shared
FOOTER
} > "$CONFIG.tmp"

mv "$CONFIG.tmp" "$CONFIG"
chmod 600 "$CONFIG"
