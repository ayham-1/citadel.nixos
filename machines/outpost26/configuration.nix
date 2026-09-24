{...}: {
  imports = [
    ../common/configuration.nix

    ./hardware.nix

    ../../profiles/common.nix
    ../../profiles/impermanence.nix
    ../../profiles/social.nix
    ../../profiles/development.nix
    ../../profiles/office.nix

    ../../services/grub.nix
    ../../services/remote-desktop.nix
    ../../services/ssh-server.nix
    ../../services/tailscale.nix
    ../../services/wlans.nix
  ];

  system.autoUpgrade.enable = false;
  system.autoUpgrade.allowReboot = false;

  citadel.machine.hostName = "outpost26";

  citadel.wlans.home.enable = true;
  citadel.wlans.ovgu.enable = true;

  citadel.tailscale.enable = true;

  citadel.remote.server.enable = false;

  citadel.ssh.server.enable = false;
  citadel.ssh.server.enableYubikeyAccess = false;

  # lock in twin
  citadel.users.steam.enable = false;
  citadel.users.obsidian.enable = false;
  citadel.users.spotify.enable = false;
}
