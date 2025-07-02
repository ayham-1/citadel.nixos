{ config, sops-nix, ... }: {
  imports = [ 
    sops-nix.nixosModules.sops
  ];

  # common sops config
  sops = {
    defaultSopsFile = ./../secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      # needs to be copied into the machine host and the secrets.yaml to the citadel repo.
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = false;
    };
    secrets = {
    };
  };
}
