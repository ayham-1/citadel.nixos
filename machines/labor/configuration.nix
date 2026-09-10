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
    ../../services/ssh-server.nix
    ../../services/virt.nix
    ../../services/tailscale.nix
    ../../services/wlans.nix
  ];

  system.autoUpgrade.enable = false;
  system.autoUpgrade.allowReboot = false;

  citadel.machines.common.enable = lib.mkDefault true;
  citadel.machines.common.hostName = "labor";

  citadel.wlans.hti.enable = true;

  citadel.tailscale.enable = true;

  citadel.remote.server.enable = true;

  citadel.ssh.server.enable = true;
  citadel.ssh.server.enableYubikeyAccess = true;
}
