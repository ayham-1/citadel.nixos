{
  lib,
  config,
  ...
}: {
  imports = [
    ../../profiles/common.nix
    ../../profiles/impermanence.nix
    ../../profiles/security.nix
    ../../profiles/secrets.nix
    ../../services/localization.nix
    ../../services/nix.nix

    ../../desktop/common.nix
    ../../desktop/sound.nix

    ../../services/ssh.nix
    ../../services/time.nix
    ../../services/network.nix
    ../../services/fonts.nix
    ../../services/power.nix
    ../../services/earlyoom.nix

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
