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

## Disable `Super-p` global shortcut

```sh
nix-shell -p glib gnome.mutter --command 'env XDG_DATA_DIRS=$GSETTINGS_SCHEMAS_PATH gsettings set org.gnome.mutter.keybindings switch-monitor "[]"'
```
