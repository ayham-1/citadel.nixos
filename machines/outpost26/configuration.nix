{...}: {
  imports = [
    ../common/configuration.nix

    ./hardware.nix

    ../../desktop/obsidian.nix

    ../../profiles/common.nix
    ../../profiles/impermanence.nix
    ../../profiles/social.nix
    ../../profiles/development.nix
    ../../profiles/office.nix

    ../../services/grub.nix
    ../../services/remote-desktop.nix
    ../../services/ssh-server.nix
    ../../services/tailscale.nix
    ../../services/laptop.nix
    ../../services/wlans.nix

    ../../services/spotify.nix
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
  #citadel.steam.enable = false;

  citadel.obsidian.enable = false;
  citadel.spotify.enable = false;
}
