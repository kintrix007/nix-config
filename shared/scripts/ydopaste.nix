{
  writeShellApplication,
  wl-clipboard,
  ydotool,
}:

writeShellApplication {
  name = "ydopaste";

  runtimeInputs = [
    wl-clipboard
    ydotool
  ];

  text = ''
    sleep 2s
    ydotool type "$(wl-paste -n)"
  '';
}
