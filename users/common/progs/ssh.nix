{username, ...}: {
  home-manager.users.${username} = {pkgs, ...}: {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      settings = {
        "*" = {
          ForwardAgent = false;
          AddKeysToAgent = "yes";
          Compression = false;
          ServerAliveInterval = 0;
          ServerAliveCountMax = 3;
          HashKnownHosts = true;
          UserKnownHostsFile = "~/.ssh/known_hosts";
          ControlMaster = "no";
          ControlPath = "~/.ssh/master-%r@%n:%p";
          ControlPersist = "no";
          IdentityFile = "~/.ssh/id_ed25519_sk";
        };
        "git" = {
          Host = "github.com";
          User = "git";
          IdentitiesOnly = true;
        };

        "code.ovgu" = {
          Host = "code.ovgu.de";
          User = "git";
          identitiesOnly = true;
        };
      };
    };
  };
}
