{ pkgs, config, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    boldi = {
      isNormalUser = true;
      description = "boldi";
      extraGroups = [
        "networkmanager"
        "wheel"
        "virt-manager"
      ];
      packages = with pkgs; [ ];
    };
  };

  # ! READ THE `nixos-option` PAGE ON THIS !
  # users.mutableUsers = false;
}
