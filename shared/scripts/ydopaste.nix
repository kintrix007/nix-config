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
    ydotool type "$(wl-paste -n)"
  '';
}
