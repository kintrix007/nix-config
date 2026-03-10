{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    winboat
    freerdp
  ];

  boot.kernelModules = [
    "iptables"
    "iptable_nat"
  ];
}
