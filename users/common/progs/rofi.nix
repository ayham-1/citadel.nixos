{username, ...}: {
  home-manager.users.${username} = {
    programs.rofi = {
      enable = true;

      extraConfig = {
        modi = "drun,run";
        show-icons = true;
      };
    };
  };
}
