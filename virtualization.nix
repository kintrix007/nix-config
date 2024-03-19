{ pkgs, config, ... }:

{
  # virtualisation.waydroid.enable = true; # Leads to dangling symlinks
  # virtualisation.docker.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  virtualisation.libvirtd.enable = true;

  environment.systemPackages = with pkgs; [
      qemu_full
      virt-manager
      # gnome.gnome-boxes
  ];
}
