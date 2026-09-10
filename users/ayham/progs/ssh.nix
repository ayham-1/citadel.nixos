{
  lib,
  config,
  ...
}: {
  home-manager.users.ayham = {pkgs, ...}: {
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
  users.users.ayham.openssh.authorizedKeys.keys = lib.mkIf config.citadel.ssh.server.enableYubikeyAccess [
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIBEuye7nS9bwj75Io0XnlEjyKJvX7g5zmQh2vuI2hVZ2AAAABHNzaDo= yubikey-global-ssh"
  ];
}
