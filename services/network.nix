{ config, pkgs, ... }: {
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [ wpa_supplicant networkmanager ];
}
