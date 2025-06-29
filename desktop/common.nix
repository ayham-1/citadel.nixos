{ config, pkgs, lib, ... }: {
  # enable brightness control
  programs.light.enable = true;

  programs.dconf.enable = true;

  # common tools
  environment.systemPackages = with pkgs; [
    bitwarden
    bitwarden-cli
    mpv
    thunar
  ];
}
