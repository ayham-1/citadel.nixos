{
  lib,
  config,
  ...
}: {
  imports = [
    ./../common/bundle.nix
  ];

  citadel.users.ayham = {
    git = {
      enable = true;
      key = "8C38DD3A3030F8AEB8A9A2BC783F6DE277DA7BFF";
      name = "ayham-1";
      email = "me@ayham.xyz";
    };

    gpg = {
      enable = true;
      key = "41FE9D7D43999B0A0344E4F4900E1E1A3E142065";
    };
  };

  users.users.ayham.openssh.authorizedKeys.keys = lib.mkIf config.citadel.ssh.server.enableYubikeyAccess [
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIBEuye7nS9bwj75Io0XnlEjyKJvX7g5zmQh2vuI2hVZ2AAAABHNzaDo= yubikey-global-ssh"
  ];
}
