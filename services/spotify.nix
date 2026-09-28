{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    citadel.spotify.enable = lib.mkEnableOption "Citadel: enable spotify";
  };

  config = lib.mkIf config.citadel.spotify.enable {
    environment.systemPackages = with pkgs; [
      spotify-qt
      spotify
    ];

    citadel.allowedUnfree = ["spotify"];
  };
}
