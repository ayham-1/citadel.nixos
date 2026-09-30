{
  lib,
  config,
  ...
}: {
  options = {
    citadel.kdeconnect.enable = lib.mkEnableOption "Citadel: enable kdeconnect";
  };

  config = lib.mkIf config.citadel.kdeconnect.enable {
    programs.kdeconnect.enable = true;

    networking.firewall = rec {
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };
}
