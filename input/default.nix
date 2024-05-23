{ pkgs, config, ... }:

{
  imports = [
    ./ibus.nix
    ./kmonad
  ];

  services.xserver.xkb = {
    options = "compose:rctrl";
    layout = "us";
    variant = "";
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
