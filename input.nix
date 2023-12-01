{ pkgs, config, ... }:

{

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      mozc
    ];
    # fcitx5.addons = with pkgs; [
    #   fcitx5-mozc
    #   fcitx5-gtk
    # ];
  };

  # environment.sessionVariables =
  #   let ime = "fcitx";
  #   in {
  #     INPUT_METHOD = ime;
  #     QT_IM_MODULE = ime;
  #     GTK_IM_MODULE = ime;
  #     XMODIFIERS = "@im=${ime}";
  #     XIM_SERVERS = ime;
  #   };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
}
