{ ... }:

{
  networking.wg-quick.interfaces.wg0.configFile = "${./wg0.conf}";
}
