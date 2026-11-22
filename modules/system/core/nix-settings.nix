{self, ...}: {
  flake.citadel.modules.core.nix-settings = {
    pkgs,
    lib,
    ...
  }: let
    modules = with self.citadel.modules.core; [
      users.cremator
    ];
  in {
    imports = modules;

    nix = {
      settings = {
        sandbox = true;
        trusted-users = ["cremator"];
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
      };

      optimise = {
        automatic = true;
        persistent = true;
      };

      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 14d";
      };
    };

    programs.nh.enable = true;
  };
}
