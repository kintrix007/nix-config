{ pkgs, config, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kin = {
    isNormalUser = true;
    description = "kin";
    extraGroups = [
      "networkmanager"
      "wheel"
      # ! Do not add docker group. That is basically the same as root.
      # "docker"

      # For KMonad
      "input"
      "uinput"
    ];
    packages = with pkgs; [
      gh
      # vscode
      # neovim
      vscodium

      # vlc
      mpv
      libgourou # To remove DRM from .acsm files

      # jetbrains.clion
      jetbrains.idea-ultimate
      # jetbrains.rider

      itch
      butler
    ];
  };
}
