{ config, lib, sops-nix, ... }: {
  imports = [ sops-nix.nixosModules.sops ];

  sops = {
    secrets = lib.mkMerge [{
      "private_keys/ssh/ayham" = {
        mode = "0400";
        path = "/home/ayham/.ssh/id_ayham";
        owner = config.users.users.ayham.name;
        group = config.users.users.ayham.group;
      };
      "private_keys/gpg/ayham" = {
        mode = "0400";
        path = "/home/ayham/.gnupg/ayham-gpg.asc";
        owner = config.users.users.ayham.name;
        group = config.users.users.ayham.group;
      };
    }];
  };
}
