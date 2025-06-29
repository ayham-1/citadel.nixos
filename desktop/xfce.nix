{ config, pkgs, callPackage, ... }:
{
  services.xserver = {
    desktopManager.xfce.enable = true;
  };

  environment.systemPackages = with pkgs; [
    iwgtk
  ];
}
