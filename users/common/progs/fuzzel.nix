{username, ...}: {
  home-manager.users.${username} = {
    programs.fuzzel = {
      enable = true;
      settings = {
        border = {
          radius = 0;
          width = 1;
        };
      };
    };
  };
}
