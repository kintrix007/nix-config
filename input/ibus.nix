{ pkgs, config, ... }:

let
  oldPkgs = import
    (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/1b7a6a6e57661d7d4e0775658930059b77ce94a4.tar.gz";
    })
    { };
in
{
  i18n.inputMethod = {
    enabled = "ibus";
    # 1.5.28 has some major issues:
    # https://github.com/ibus/ibus/issues/2480
    # Downgrading to 1.5.27 fixes it
    # Or alternatively, set IBUS_ENABLE_SYNC_MODE=1
    ibus.engines = with oldPkgs.ibus-engines; [
      mozc
    ];
  };

  environment.sessionVariables = {
    IBUS_ENABLE_SYNC_MODE = "1";
  };

}
