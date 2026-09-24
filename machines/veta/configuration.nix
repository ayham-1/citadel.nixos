{
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
    ../../services/laptop.nix
  ];

  system.autoUpgrade.enable = false;
  system.autoUpgrade.allowReboot = false;

  citadel.machine.hostName = "veta";

  citadel.wlans.home.enable = true;
  citadel.wlans.ovgu.enable = true;

  citadel.tailscale.enable = true;
}
