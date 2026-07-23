{
  writeShellApplication,
  coreutils,
}:

writeShellApplication {
  name = "mkpass";

  runtimeInputs = [
    coreutils
  ];

  text = /* bash */ ''
    shuf -n4 "$WORDLIST"  | tr -d '\n'
    echo
  '';
}
