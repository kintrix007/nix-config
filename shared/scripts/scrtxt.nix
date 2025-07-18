{
  writeShellApplication,
  gnome-screenshot,
  imagemagick,
  libnotify,
  tesseract,
  wl-clipboard,
}:

writeShellApplication {
  name = "scrtxt";

  runtimeInputs = [
    gnome-screenshot
    imagemagick
    libnotify
    tesseract
    wl-clipboard
  ];

  text = ''
    TMP="$(mktemp -d)"
    trap 'rm -r $TMP' EXIT

    cd "$TMP"
    gnome-screenshot -a -f area.png
    if ! [[ -f area.png ]]; then
      exit
    fi

    mogrify -modulate 100,0 -resize 200% area.png
    tesseract area.png area 2>/dev/null

    wl-copy -n < area.txt
    notify-send -a "scrtxt" -i "display" -t 1000 -u normal \
      "Screenshot Read" \
      "Copied: $(<area.txt head -c30)"

    cat area.txt
  '';
}
