{lib, ...}: {
  imports = [
    ../common/configuration.nix

    ./hardware.nix

    ../../profiles/impermanence.nix
    ../../profiles/social.nix
    ../../profiles/development.nix
    ../../profiles/office.nix

    ../../services/grub.nix
    ../../services/remote-desktop.nix
    ../../services/tailscale.nix
    ../../services/wlans.nix
  ];

  system.autoUpgrade.enable = false;
  system.autoUpgrade.allowReboot = false;

  citadel.machines.common.enable = lib.mkDefault true;
  citadel.machines.common.hostName = "veta";

  citadel.wlans.home.enable = true;
  citadel.wlans.ovgu.enable = true;

  citadel.tailscale.enable = true;
}
