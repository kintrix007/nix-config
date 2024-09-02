{ ... }:

{
  imports = [
    ./obs.nix
  ];

  home-manager.users.kin = { pkgs, ... }: {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        input-overlay
        obs-pipewire-audio-capture
      ];
    };

    home.stateVersion = "23.11";
  };
}
