{ config, pkgs, lib, home-manager, ... }: {
  home-manager.users.ayham = { pkgs, ... }: {
    programs.git = {
      enable = true;
      userName = "ayham-1";
      userEmail = "me@ayham.xyz";
      signing.key = "8C38DD3A3030F8AEB8A9A2BC783F6DE277DA7BFF";
      signing.signByDefault = true;
      diff-so-fancy.enable = true;
    };
  };
}
