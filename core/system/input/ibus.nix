{ pkgs, config, ... }:

{
  i18n.inputMethod = {
    enabled = "ibus";
    # 1.5.28 has some major issues:
    # https://github.com/ibus/ibus/issues/2480
    # Downgrading to 1.5.27 fixes it
    # Or alternatively, set IBUS_ENABLE_SYNC_MODE=1
    ibus.engines = with pkgs.ibus-engines; [
      mozc
    ];
  };

  environment.sessionVariables = {
    IBUS_ENABLE_SYNC_MODE = "1";
  };
}
