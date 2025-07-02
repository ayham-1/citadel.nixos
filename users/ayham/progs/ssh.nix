{ config, pkgs, lib, home-manager, ... }: 
let identityFiles = ["id_ayham"];
in
  {
    programs.ssh = {
      startAgent = true;
    };
    home-manager.users.ayham = { pkgs, ... }: {
      programs.ssh = {
        enable = true;
        addKeysToAgent = "yes";

        matchBlocks = {
          "git" = {
            host = "github.com";
            user = "git";
            forwardAgent = true;
            identitiesOnly = true;
            identityFile = lib.lists.forEach identityFiles (file: "/home/ayham/.ssh/${file}");
          };
        };
      };
    };
  }
