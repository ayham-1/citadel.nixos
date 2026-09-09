{lib, ...}: {
  imports = [
    ../common/configuration.nix

    ../../profiles/impermanence.nix
    ./hardware.nix

    ../../profiles/social.nix
    ../../profiles/development.nix
    ../../profiles/office.nix

    ../../services/grub.nix
    ../../services/remote-desktop.nix
    ../../services/ssh-server.nix
    ../../services/virt.nix
    ../../services/tailscale.nix
    ../../services/wlans.nix
  ];

  system.autoUpgrade.enable = false;
  system.autoUpgrade.allowReboot = false;

  citadel.machines.common.enable = lib.mkDefault true;
  citadel.machines.common.hostName = "alpha";

  citadel.wlans.home.enable = true;

  citadel.tailscale.enable = true;
}
