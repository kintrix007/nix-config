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
        "libvirtd"

        # For KMonad
        "input"
        "uinput"
      ];
      packages = with pkgs; [
        gh
      ];
    };

    itch = {
      isSystemUser = true;
      password = null;
      group = "itch";
    };
  };

  users.groups.itch = {};
}
