{
  config,
  pkgs,
  lib,
  home-manager,
  ...
}: {
  home-manager.users.ayham = {pkgs, ...}: {
    programs.git = {
      enable = true;
      lfs.enable = true;

      signing = {
        signByDefault = true;
        key = "8C38DD3A3030F8AEB8A9A2BC783F6DE277DA7BFF";
      };

      settings = {
        user = {
          name = "ayham-1";
          email = "me@ayham.xyz";
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
