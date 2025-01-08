#!/usr/bin/env nix-shell
#!nix-shell -p vim bash
#!nix-shell -i bash

set -euo pipefail

gen-hash() {
  HASH="$(LC_ALL=C tr -dc 'a-f0-9' </dev/urandom | head -c 8)"
}

# Back up previous nixos config
if [ -e /etc/nixos ]; then
  gen-hash
  while [ -e "/etc/nixos-${HASH}.bak" ]; do
    gen-hash
  done

  sudo mv /etc/nixos "/etc/nixos-${HASH}.bak"
  echo "Copied previous configuration to /etc/nixos-${HASH}.bak."
fi

cd "${BASH_SOURCE:-$0}"
sudo ln -s "$PWD" /etc/nixos
sudo nixos-generate-config
cp configuration.nix.skel configuration.nix
$EDITOR configuration.nix # Specify which host and stateVersion to use
sudo nixos-rebuild switch --upgrade
