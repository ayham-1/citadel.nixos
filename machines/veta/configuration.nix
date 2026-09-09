{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common/configuration.nix

    ../../profiles/impermanence.nix

    ./hardware.nix
  ];

  citadel.machines.common.hostName = "veta";

  system.autoUpgrade.enable = false;
  system.autoUpgrade.allowReboot = false;

  citadel.machines.common.enable = lib.mkDefault true;
}
