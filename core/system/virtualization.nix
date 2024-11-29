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
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };

  virtualisation.spiceUSBRedirection.enable = true;

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    qemu_full
    distrobox
    # gnome.gnome-boxes
    spice-gtk
    # virtiofsd

    # (spice-gtk.overrideAttrs (final: prev: {
    #   # installPhase = ''
    #   #   runHook preInstall
    #   #
    #   #   runHook postInstall
    #   # '';
    #
    #   postInstall = ''
    #     chmod 4755 $out/bin/spice-client-glib-usb-acl-helper
    #   '';
    # }))
  ];

  # security.wrappers.spice-client-glib-usb-acl-helper = {
  #   owner = "boldi";
  #   source = "${pkgs.spice-gtk}/bin/spice-client-glib-usb-acl-helper";
  # };
}
