{ pkgs, config, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    kin = {
      isNormalUser = true;
      description = "kin";
      extraGroups = [
        "networkmanager"
        "wheel"
        # ! Do not add docker group. That is basically the same as root.
        # "docker"

        # For virt-manager
        "kvm"
        "libvirtd"

        # For ydotool
        "ydotool"

        # For adb
        "adbusers"

        # For spice-gtk
        "spice"

        # For mtkclient
        "plugdev"
        "dialout"

        # For KMonad
        "input"
        "uinput"
      ];
      packages = with pkgs; [
        gh
      ];
    };

    wikipedia-race = {
      isNormalUser = true;
      description = "wikipedia-race";
      extraGroups = [
        "networkmanager"
      ];
    };

    itch = {
      isSystemUser = true;
      password = null;
      group = "itch";
    };
  };

  users.groups = {
    plugdev = {};
    itch = {};
  };

  # ! READ THE `nixos-option` PAGE ON THIS !
  # users.mutableUsers = false;
}
