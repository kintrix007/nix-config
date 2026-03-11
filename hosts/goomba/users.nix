{ ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    boldi = {
      isNormalUser = true;
      group = "boldi";
      description = "boldi";
      extraGroups = [
        "users"

        "networkmanager"
        "wheel"

        # For virt-manager
        "kvm"
        "libvirtd"

        # For adb
        "adbusers"

        # For spice-gtk
        "spice"

        # For ydotool
        "ydotool"

        # For wireshark
        "wireshark"

        # ? May be necessary for DR Sprinto?
        # "video"
        # "render"
      ];
      packages = [ ];
    };
  };

  users.groups = {
    wireshark = { };
    boldi = { };
  };

  # ! READ THE `nixos-option` PAGE ON THIS !
  # users.mutableUsers = false;
}
