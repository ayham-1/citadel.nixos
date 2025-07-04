{ config, sops-nix, ... }: {
  imports = [ sops-nix.nixosModules.sops ];

  # common sops config
  sops = {
    defaultSopsFile = "/persistent/etc/sops/secrets.yaml";
    defaultSopsFormat = "yaml";
    validateSopsFiles = false;
    age = {
      # needs to be copied into the machine host and the secrets.yaml to the citadel repo.
      keyFile = "/persistent/etc/sops/keys.txt";
      generateKey = false;
    };
    secrets = { };
  };
}
