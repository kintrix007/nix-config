# Notes

## Install something from the unstable channel

```sh
nix-env -f channel:nixpkgs-unstable -iA pkgname
# e.g.
nix-env -f channel:nixpkgs-unstable -iA godot_4
```

Generate `hardware-configuration.nix` by running

```sh
nixos-generate-config
```
