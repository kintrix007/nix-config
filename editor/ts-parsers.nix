{ pkgs }:

with pkgs.vimPlugins.nvim-treesitter-parsers; [
  agda
  awk
  bash
  c
  c_sharp
  cpp
  dart
  elm
  gdscript
  haskell
  janet_simple
  java
  javascript
  julia
  lua
  nim
  nix
  python
  rust
  sql
  teal
  terraform
  tsx
  typescript
  v
  vala
  vim
  zig

  cmake
  diff
  jq
  make
  passwd
  ssh_config
  udev

  csv
  dhall
  dockerfile
  doxygen
  json
  json5
  jsonc
  markdown
  markdown_inline
  toml
  vimdoc
  xml
  yaml
]
