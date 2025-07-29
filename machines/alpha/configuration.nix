{ lib, config, pkgs, ... }: {
  imports = [ ../common/configuration.nix ];

  citadel.machines.common.hostName = "alpha";

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  citadel.machines.common.enable = lib.mkDefault true;
}
