{
  lib,
  config,
  ...
}: {
  home-manager.users.ayham = {pkgs, ...}: {
    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes";
      enableDefaultConfig = true;

      matchBlocks = {
        "git" = {
          host = "github.com";
          user = "git";
          forwardAgent = true;
          identitiesOnly = true;
        };
        "code.ovgu" = {
          host = "code.ovgu.de";
          user = "git";
          forwardAgent = true;
          identitiesOnly = true;
        };
        "*" = {
          identityFile = "~/.ssh/id_ed25519_sk";
        };
      };
    };
  };
  users.users.ayham.openssh.authorizedKeys.keys = lib.mkIf config.citadel.ssh.server.enableYubikeyAccess [
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIBEuye7nS9bwj75Io0XnlEjyKJvX7g5zmQh2vuI2hVZ2AAAABHNzaDo= yubikey-global-ssh"
  ];
}
