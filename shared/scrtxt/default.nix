{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "scrtxt";

      runtimeInputs = with pkgs; [
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
        # ? Image to text
        tesseract area.png area 2>/dev/null

        wl-copy -n < area.txt
        notify-send -a "scrtxt" -i "display" -t 1000 -u normal \
          "Screenshot Read" \
          "The text in the screenshot has been copied to your clipboard"
        cat area.txt
      '';
    })
  ];
}
