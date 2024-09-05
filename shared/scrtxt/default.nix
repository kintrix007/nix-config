{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "scrtxt";

      runtimeInputs = with pkgs; [
        gnome.gnome-screenshot
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
        mogrify -modulate 100,0 -resize 400% area.png
        # ? Image to text
        tesseract area.png area 2>/dev/null

        wl-copy -n < area.txt
        notify-send "Screenshot Read" \
          "The text in the screenshot has been copied to your clipboard"
        cat area.txt
      '';
    })
  ];
}
