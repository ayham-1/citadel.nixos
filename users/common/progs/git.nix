{
  lib,
  config,
  username,
  ...
}: {
  imports = [
    ../user-settings.nix
  ];

  config = {
    programs.git = lib.mkIf config.citadel.users.${username}.git.enable {
      enable = true;
      lfs.enable = true;

      signing = {
        signByDefault = true;
        key = config.citadel.users.${username}.git.key;
      };

      settings = {
        user = {
          name = config.citadel.users.${username}.git.name;
          email = config.citadel.users.${username}.git.email;
        };

        # very questionable, but needed for sshfs
        safe = {
          directory = "*";
        };
      };
    };

    programs.diff-so-fancy = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
