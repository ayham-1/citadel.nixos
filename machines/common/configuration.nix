{ lib, config, pkgs, ... }: {
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
    ../../services/remote-desktop.nix
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
    ../../services/wlans.nix

    ./hardware.nix
  ];

  options = {
    citadel.machines.common.hostName = lib.mkOption {
      type = lib.types.str;
      default = "commonHostName";
    };
  };

  config = {
    networking.hostName = config.citadel.machines.common.hostName;
    system.stateVersion = "25.05";
  };
}
