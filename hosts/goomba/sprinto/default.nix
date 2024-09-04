{ pkgs ? import <nixpkgs> { } }:

pkgs.callPackage ./drsprinto.nix { }
