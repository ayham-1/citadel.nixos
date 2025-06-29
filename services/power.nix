{ config, pkgs, lib, ... }: {
  powerManagement.enable = true;
  services.thermald.enable = true;
}
