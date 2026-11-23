{...}: {
  flake.citadel.modules.network.lans = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options = {
      citadel.lans.home.enable = lib.mkEnableOption "Citadel: lan home";
    };

    config = {
      sops.secrets."wireless.env".neededForUsers = true;
      sops.secrets."wireless.env" = {};

      networking = {
        networkmanager = {
          ensureProfiles = {
            environmentFiles = [config.sops.secrets."wireless.env".path];
            profiles = {
              home-lan = lib.mkIf config.citadel.lans.home.enable {
                connection = {
                  id = "trusted-ethernet";
                  type = "802-3-ethernet";
                  zone = "trusted-lan";
                  autoconnect = true;
                };
              };
            };
          };
        };
      };
    };
  };
}
