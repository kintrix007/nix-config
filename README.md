# Kintrix's NixOS Configuration

## Switch to This Config

Run the following, with the appropriate privileges (may require `sudo`):

```sh
git clone https://github.com/kintrix007/nix-config /etc/nixos
cd /etc/nixos
nixos-generate-config
cp configuration.nix.skel configuration.nix
vim configuration.nix # Specify which host and stateVersion to use
nixos-rebuild switch --upgrade
```

Or use the `setup.sh` script, which effectively does the same (may require
`sudo`:

```sh
git clone https://github.com/kintrix007/nix-config /var/nixos-config
cd /var/nixos-config
./setup.sh # Will symlink $PWD to /etc/nixos
```

This setup script does not override the previous NixOS configuration if it
exists. It instead copies it to `/etc/nixos-${HASH}.bak` and prints it to
STDOUT.
