{
  lib,
  config,
  pkgs,
  username,
  ...
}: {
  options = {
    citadel.users.spotify.enable = lib.mkEnableOption "Citadel: enable users spotify";
  };

  config = lib.mkIf config.citadel.users.spotify.enable {
    home-manager.users.${username} = {pkgs, ...}: {
      services.spotifyd = {
        enable = true;
      };
    };
    networking.firewall.allowedUDPPorts = [5353];

    environment.systemPackages = with pkgs; [
      spotify-qt
    ];
  };
}
