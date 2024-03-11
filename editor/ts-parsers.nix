{ pkgs }:

with pkgs.vimPlugins.nvim-treesitter-parsers; [
  lua
  teal
  c
  cpp
  rust
  zig
  haskell
  agda
  nix
  python
  bash
  awk
  typescript
  javascript
  tsx
  janet_simple
  julia
  vim
  vala
  v
  nim
  sql
  c_sharp

  passwd
  udev
  ssh_config
  diff
  jq
  cmake
  make

  yaml
  json
  jsonc
  json5
  toml
  xml
  doxygen
  dockerfile
  csv
  dhall
]
