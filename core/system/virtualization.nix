{ pkgs, ... }:

{
  # virtualisation.waydroid.enable = true; # Crashes wayland session last I tried.

  # virtualisation.docker.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu.ovmf.enable = true;
    qemu.swtpm.enable = true;
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    qemu_full
    distrobox
    # gnome.gnome-boxes
  ];
}
