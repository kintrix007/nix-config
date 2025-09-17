{ ... }:

{
  services.udev.extraRules = /* udev */ ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="044f", MODE="0666"
    # Thrustmaster Universal Challenge
    KERNEL=="event*", ATTRS{idProduct}=="b657", ATTRS{idVendor}=="044f", MODE="0666" GROUP="input"
  '';
}
