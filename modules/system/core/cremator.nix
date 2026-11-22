{...}: {
  flake.citadel.modules.core.users.cremator = {
    pkgs,
    lib,
    ...
  }: {
    users = {
      # the 'cremator' is responsible for nix store management,
      # and possibly also for other maintenance-related jobs
      users = {
        "cremator" = {
          description = "Maintains the Citadel Realm.";
          group = "cremator";

          shell = null;
          isNormalUser = false;
          isSystemUser = true;
          linger = false; # for future use

          # TODO: do sops secrets

          extraGroups = ["networkmanager"];
        };
      };
    };
  };
}
