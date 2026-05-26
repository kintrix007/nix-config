{
  writeShellApplication,
}:

writeShellApplication {
  name = "delayed";

  runtimeInputs = [];

  text = ''
    sleep 1s
    "$@"
  '';
}
