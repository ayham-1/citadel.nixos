{
  lib,
  config,
  username,
  ...
}: {
  options = {
    citadel.users.${username}.git = {
      enable = lib.mkEnableOption "user: enable git";
      key = lib.mkOption {};
      name = lib.mkOption {};
      email = lib.mkOption {};
    };
  };

  config = {
    home-manager.users.${username} = {pkgs, ...}: {
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
  };
}
