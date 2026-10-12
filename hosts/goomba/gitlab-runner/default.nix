{ lib, ... }:

{
  # This is how the setup communicates with Docker
  virtualisation.podman.dockerSocket.enable = true;

  services.gitlab-runner = {
    enable = true;
    clear-docker-cache = {
      enable = true;
      dates = "monthly";
    };

    # This config file might be obsolete. Consider adding the secrets to
    # goomba.env instead and all the actual config in this nix file.
    configFile = "/etc/gitlab-runner/config.toml";
    settings = {
      concurrent = 2;
    };

    services.goomba = {
      authenticationTokenConfigFile = "/etc/gitlab-runner/goomba.env";
      executor = "docker";
      dockerImage = "docker.io/library/alpine:latest";
      registrationFlags = [ "--docker-host unix:///run/podman/podman.sock" ];
    };
  };

  # The gitlab-runner module enables Docker by default for docker executors,
  # which conflicts with Podman's dockerCompat/dockerSocket. Force it off.
  virtualisation.docker.enable = lib.mkForce false;

  systemd.services.gitlab-runner = {
    after = [ "podman.socket" ];
    requires = [ "podman.socket" ];
    serviceConfig.SupplementaryGroups = [ "podman" ];
  };
}
