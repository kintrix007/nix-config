{
  services.usbmuxd.enable = true;

  services.udev.extraRules = /* udev */ ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="05ac", ATTRS{idProduct}=="1281", TAG+="uaccess"
  '';
}
