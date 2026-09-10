{
  config,
  lib,
  sops-nix,
  ...
}: {
  imports = [sops-nix.nixosModules.sops];

  # common sops config
  sops = {
    defaultSopsFile = "/persistent/etc/sops/secrets.yaml";
    defaultSopsFormat = "yaml";
    validateSopsFiles = false;
    age = {
      # needs to be copied into the install machine and the secrets.yaml
      keyFile = "/persistent/etc/sops/keys.txt";
      generateKey = false;
    };
    secrets = lib.mkMerge [
      (lib.mkIf config.citadel.tailscale.enable {
        "private_keys/tailscale" = {
          mode = "0400";
          path = "/root/.tailscale.key";
        };
      })
    ];
  };
}
