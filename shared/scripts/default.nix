{
  lib,
  config,
  pkgs,
  ...
}:

let
  optList = [
    "scrtxt"
    "ydopaste"
  ];
  mkScriptOption = name: {
    "${name}".enable = lib.mkOption {
      default = true;
      example = false;
      type = with lib.types; bool;
      description = ''
        Install ${name} on PATH.
      '';
    };
  };
  isEnabled = name: config.scripts."${name}".enable;
  # mergeDisjointAttrsList = lib.foldr lib.attrsets.unionOfDisjoint {};
in
{
  options = {
    scripts = lib.attrsets.mergeAttrsList (lib.map mkScriptOption optList);
  };

  config =
    {
      environment.systemPackages = lib.pipe optList [
        (lib.filter isEnabled)
        (lib.map (name: pkgs.callPackage ./${name}.nix { }))
      ];
    };
}
