{
  lib,
  config,
  ...
}: {
  imports = [
    ../common/configuration.nix

    ./hardware.nix

    ../../profiles/common.nix
    ../../profiles/impermanence.nix
    ../../profiles/social.nix
    ../../profiles/development.nix
    ../../profiles/office.nix

    ../../profiles/hardware/zsa.nix

    ../../services/grub.nix
    ../../services/remote-desktop.nix
    ../../services/ssh-server.nix
    ../../services/virt.nix
    ../../services/tailscale.nix
    ../../services/wlans.nix
  ];

  system.autoUpgrade.enable = false;
  system.autoUpgrade.allowReboot = false;

  citadel.machine.hostName = "alpha";

  citadel.wlans.home.enable = true;

  citadel.tailscale.enable = true;

  citadel.remote.server.enable = true;

  citadel.ssh.server.enable = true;
  citadel.ssh.server.enableYubikeyAccess = true;

  # lock in twin
  citadel.users.steam.enable = false;
  citadel.users.obsidian.enable = true;

  citadel.hardware.zsa.enable = true;
}
