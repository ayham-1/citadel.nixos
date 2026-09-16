{ config, pkgs, lib, ...}:

{
  environment.systemPackages = with pkgs; [
    maestral
    maestral-gui
  ];
}
