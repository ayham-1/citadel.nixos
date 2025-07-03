{ config, pkgs, ... }: {
  imports = [
    ../../profiles/common.nix
    ../../profiles/communication.nix
    ../../profiles/development.nix
    ../../profiles/dev-tools.nix
    ../../profiles/security.nix
    ../../profiles/office.nix
    ../../profiles/secrets.nix
    ../../profiles/impermanence.nix

    ../../desktop/common.nix
    ../../desktop/sound.nix
    ../../desktop/sway.nix

    ../../services/nix.nix
    ../../services/localization.nix
    ../../services/ssh.nix
    ../../services/ssh-server.nix
    ../../services/dns.nix
    ../../services/ntp.nix
    ../../services/virt.nix
    ../../services/wifi.nix
    ../../services/fonts.nix
    ../../services/power.nix
    ../../services/earlyoom.nix
    ../../services/tor.nix

    ./hardware.nix
  ];

  networking.hostName = "alpha";

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  system.stateVersion = "25.05";
}
