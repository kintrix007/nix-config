{ pkgs, ... }:

{
  nixpkgs.config.android_sdk.accept_license = true;

  environment.systemPackages = with pkgs; [
    android-studio-tools
    android-tools
    androidenv.androidPkgs_9_0.androidsdk
  ];
}
