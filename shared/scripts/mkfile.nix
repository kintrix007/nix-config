{
  writeShellApplication,
  coreutils,
}:

writeShellApplication {
  name = "mkfile";

  runtimeInputs = [
    coreutils
  ];

  text = builtins.readFile ./mkfile.sh;
}
