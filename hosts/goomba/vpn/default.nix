{ ... }:

{
  # Rotterdam
  networking.wg-quick.interfaces.wtss-rtd.configFile = "${./wtss-rtd.conf}";
  # Amsterdam
  networking.wg-quick.interfaces.wtss-ams.configFile = "${./wtss-ams.conf}";
}
