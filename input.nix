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

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  services.xserver.libinput = {
    enable = true;
    touchpad = {
      tapping = true; # Tap to click
      disableWhileTyping = true;
      # Bottom right for right click, bottom middle for middle click
      clickMethod = "buttonareas";
      # Two fingers for right click, three fingers for middle click
      # clickMethod = "clickfinger";
      naturalScrolling = true;
      scrollMethod = "twofinger";
    };
    mouse = {
      naturalScrolling = false;
      middleEmulation = false; # Emulate middle click with left + right click
      scrollButton = null;
    };
  };
}
