let
  url = "https://github.com/NixOS/nixpkgs/archive/93d692f43b144599f8d510434013602e7f291734.tar.gz";
in
{ pkgs ? import (fetchTarball url) { } }:

pkgs.stdenv.mkDerivation {
  pname = "vlc-bittorent";
  version = "2.15.0";
  src = fetchGit {
    url = "https://github.com/johang/vlc-bittorrent";
    rev = "6810d479e6c1f64046d3b30efe78774b49d1c95b";
    ref = "master";
  };

  nativeBuildInputs = with pkgs; [
    gcc
    autoconf
    autoconf-archive
    automake
    gnumake
    pkg-config
  ];

  buildInputs = with pkgs; [
    libtorrent-rasterbar
    libvlc
    libtool
    openssl
    boost
  ];

  buildPhase = ''
    autoreconf -i
    ./configure --prefix=$out
    make
  '';

  installPhase = ''
    make install
  '';
}
