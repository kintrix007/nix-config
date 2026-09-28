# Kintrix's NixOS Configuration

## Pipe into nix-output-monitor

Make sure to use `./rebuild.sh` instead of `nixos-rebuild`.

## Setup

```sh
sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
sudo nix-channel --add https://channels.nixos.org/nixpkgs-unstable nixpkgs-unstable
```

## Switch to This Config

Run the following, with the appropriate privileges (may require `sudo`):

```sh
git clone https://git.sr.ht/~kintrix/nixos-config ~/nixos-config
mv /etc/nixos /etc/nixos.bak
ln -s ~/nixos-config /etx/nixos
nixos-generate-config
cd ~/nixos-config
cp configuration.nix.skel configuration.nix
vim configuration.nix  # Set host and stateVersion
./rebuild.sh switch --upgrade
```
