{ pkgs, config, ... }:

{
  virtualisation.libvirtd.enable = true;

  environment.systemPackages = with pkgs; [
      qemu
      virt-manager
      gnome.gnome-boxes
  ];
}
