{ ... }:

{
  imports = [];

  home-manager.users.kin = { pkgs, ... }: {
    # programs.obs-studio = {
    #   enable = true;
    #   plugins = with pkgs.obs-studio-plugins; [
    #     input-overlay
    #     obs-pipewire-audio-capture
    #   ];
    # };

    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };

    home.stateVersion = "23.11";
  };
}
