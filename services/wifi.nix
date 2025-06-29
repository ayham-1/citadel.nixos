{ config, pkgs, ... }: {
  networking.networkmanager.enable = true;

  networking.wireless.enable = true;

  environment.systemPackages = with pkgs; [
    wireless-tools
    wpa_supplicant
    networkmanager
    nm-connection-editor
  ];
}
